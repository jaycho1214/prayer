import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prayer/constants/dio.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/errors.dart';
import 'package:prayer/model/user_model.dart';
import 'package:prayer/repo/response_types.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

enum FollowersType { followings, followers }

class UserRepository {
  Future<PUser?> fetchUser({
    String? uid,
    String? username,
  }) async {
    final resp = await (uid != null
        ? dio.get('/v1/users/$uid')
        : dio.get('/v1/users/by/username/$username'));
    final user =
        resp.data['data'] == null ? null : PUser.fromJson(resp.data['data']);
    return user;
  }

  Future<void> followUser({
    required String uid,
    required bool value,
  }) async {
    mixpanel.track("User Followed");
    await dio.post('/v1/users/$uid/follows', data: {
      'value': value,
    });
  }

  Future<void> deleteUser() async {
    mixpanel.track("User Deleted");
    await dio.delete('/v1/users');
  }

  Future<PaginationResponse<PUser, String?>> fetchFollowers(String uid,
      {String? cursor, FollowersType type = FollowersType.followings}) async {
    try {
      final resp = await dio.get('/v1/users/$uid/${type.name}',
          queryParameters: {'cursor': cursor});
      final user = resp.data['data'] == null
          ? <PUser>[]
          : List<Map<String, dynamic>>.from(resp.data['data'])
              .map((e) => PUser.fromJson(e))
              .toList();
      return PaginationResponse<PUser, String?>(
        items: user,
        cursor: resp.data['cursor'],
        error: null,
      );
    } on DioException catch (e) {
      String? errorMessage;
      if (e.response?.data['message'] != null) {
        errorMessage = e.response?.data['message'];
      } else {
        errorMessage = 'Unknown Error Occured';
      }
      return PaginationResponse<PUser, String?>(
        items: null,
        cursor: null,
        error: errorMessage,
      );
    } catch (e) {
      return PaginationResponse<PUser, String?>(
        items: null,
        cursor: null,
        error: e.toString(),
      );
    }
  }

  Future<PUser?> createUser({
    required String username,
    required String name,
    String? bio,
  }) async {
    try {
      await dio.post(
        '/v1/users',
        data: {
          'username': username,
          'email': FirebaseAuth.instance.currentUser!.email,
          'name': name,
          'bio': bio
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return fetchUser(uid: FirebaseAuth.instance.currentUser!.uid);
    } on DioException catch (err, stackTrace) {
      if (err.response?.data['code'] == 'username-already-exists') {
        throw DuplicatedUsernameException();
      }
      Sentry.captureException(err, stackTrace: stackTrace);
      rethrow;
    } catch (err, stackTrace) {
      Sentry.captureException(err, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<String> fetchUploadLinkAndUpload(
    String path, {
    void Function(double progress)? onSendProgress,
  }) async {
    final urlResp =
        await dio.get('/v1/uploads', queryParameters: {'fileName': path});
    await dio.put(
      urlResp.data['url'],
      data: File(path).openRead(),
      onSendProgress: (count, total) => onSendProgress?.call(count / total),
      options: Options(contentType: 'image/${path.split(".").last}'),
    );
    return urlResp.data['fileName'];
  }

  double calculateTotalProgress(double progress1, double progress2) {
    if (progress1 == -1 && progress2 == -1) {
      return 1.0;
    } else if (progress1 == -1) {
      return progress2;
    } else if (progress2 == -1) {
      return progress1;
    } else {
      double totalProgress = (progress1 + progress2) / 2.0;
      return totalProgress;
    }
  }

  Future<String?> updateUser({
    String? username,
    String? name,
    String? bio,
    String? profile,
    String? banner,
    void Function(double progress)? onSendProgress,
  }) async {
    double profileProgress = profile == null ? -1 : 0;
    double bannerProgress = banner == null ? -1 : 0;
    Map<String, Future<Null>> tasks = {};
    Map<String, String> urls = {};
    if (profile != null && !profile.startsWith('https')) {
      tasks['profile'] = () async {
        final url = await fetchUploadLinkAndUpload(
          profile,
          onSendProgress: (progress) {
            profileProgress = progress;
            onSendProgress
                ?.call(calculateTotalProgress(profileProgress, bannerProgress));
          },
        );
        urls['profile'] = url;
      }();
    }
    if (banner != null && !banner.startsWith('https')) {
      tasks['banner'] = () async {
        final url = await fetchUploadLinkAndUpload(
          banner,
          onSendProgress: (progress) {
            profileProgress = progress;
            onSendProgress
                ?.call(calculateTotalProgress(profileProgress, bannerProgress));
          },
        );
        urls['banner'] = url;
      }();
    }
    await Future.wait(List.from(tasks.values));
    final resp = await dio.put(
      '/v1/users',
      data: {
        'username': username,
        'name': name,
        'bio': bio,
        'profile': profile?.startsWith('https') == true
            ? profile
            : urls['profile'] ?? '',
        'banner':
            banner?.startsWith('https') == true ? banner : urls['banner'] ?? '',
      }..removeWhere((_, value) => value?.startsWith('https') == true),
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    if (resp.data['message'] != null) {
      throw resp.data['message'];
    }
    return resp.data['data'];
  }

  Future<PaginationResponse<PUser, String?>> fetchUsers({
    String? query,
    String? cursor,
    String? excludeGroupId,
  }) async {
    try {
      final resp = await dio.get('/v1/users', queryParameters: {
        'query': query,
        'cursor': cursor,
        'excludeGroupId': excludeGroupId,
      });
      return PaginationResponse<PUser, String?>(
        items: resp.data['data'] != null
            ? List<Map<String, Object?>>.from(resp.data['data'])
                .map((e) => PUser.fromJson(e))
                .toList()
            : <PUser>[],
        cursor: resp.data['cursor'],
        error: null,
      );
    } on DioException catch (e) {
      talker.error(e);
      return PaginationResponse<PUser, String?>(
        items: null,
        cursor: null,
        error: e.response?.data['message'] ?? e.toString(),
      );
    } catch (e) {
      talker.error(e);
      return PaginationResponse<PUser, String?>(
        items: null,
        cursor: null,
        error: e.toString(),
      );
    }
  }
}
