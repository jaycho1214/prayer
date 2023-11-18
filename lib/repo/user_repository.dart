import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:prayer/constants/dio.dart';
import 'package:prayer/model/user_model.dart';

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
    if (uid == FirebaseAuth.instance.currentUser?.uid) {
      Hive.box('cache_bloc').put('myProfile', user?.toJson());
    }
    return user;
  }

  Future<void> followUser({
    required String uid,
    required bool value,
  }) async {
    await dio.post('/v1/users/$uid/follows', data: {
      'value': value,
    });
  }

  Future<Map> fetchFollowers(String uid, {String? cursor}) async {
    final resp = await dio
        .get('/v1/users/$uid/followers', queryParameters: {'cursor': cursor});
    final user = resp.data['data'] == null
        ? null
        : List<Map<String, dynamic>>.from(resp.data['data'])
            .map((e) => PUser.fromJson(e))
            .toList();
    return {'users': user, 'cursor': resp.data['cursor']};
  }

  Future<Map> fetchFollowings(String uid, {String? cursor}) async {
    final resp = await dio
        .get('/v1/users/$uid/followings', queryParameters: {'cursor': cursor});
    final user = resp.data['data'] == null
        ? null
        : List<Map<String, dynamic>>.from(resp.data['data'])
            .map((e) => PUser.fromJson(e))
            .toList();
    return {'users': user, 'cursor': resp.data['cursor']};
  }

  Future<PUser?> fetchUserByUsername(String username) async {
    final resp = await dio.get('/v1/users/by/username/$username');
    final user =
        resp.data['data'] == null ? null : PUser.fromJson(resp.data['data']);
    return user;
  }

  Future<PUser?> createUser({
    required String username,
    required String name,
    String? bio,
  }) async {
    final resp = await dio.post(
      '/v1/users',
      data: {
        'username': username,
        'email': FirebaseAuth.instance.currentUser!.email,
        'name': name,
        'bio': bio
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    if (resp.data['message'] != null) {
      throw resp.data['message'];
    }
    return fetchUser(uid: FirebaseAuth.instance.currentUser!.uid);
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

  Future<List<String>> fetchUserGroups(String uid) async {
    final resp = await dio.get('/v1/users/$uid/groups');
    if (resp.data['message'] != null) {
      throw resp.data['message'];
    }
    return List<String>.from(resp.data['data']);
  }

  Future<Map> fetchUsers({String? query, String? cursor}) async {
    final resp = await dio.get('/v1/users', queryParameters: {
      'query': query,
      'cursor': cursor,
    });
    return resp.data;
  }
}
