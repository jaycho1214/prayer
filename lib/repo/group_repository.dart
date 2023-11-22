import 'dart:io';

import 'package:dio/dio.dart';
import 'package:prayer/constants/dio.dart';
import 'package:prayer/errors.dart';
import 'package:prayer/model/group_member_model.dart';
import 'package:prayer/model/group_model.dart';
import 'package:prayer/repo/response_types.dart';

class GroupRepository {
  Future<Group?> fetchGroup(String groupId) async {
    final resp = await dio.get('/v1/groups/$groupId');
    if (resp.data['message'] != null) {
      throw resp.data['message'];
    }
    final group =
        resp.data['data'] == null ? null : Group.fromJson(resp.data['data']);
    return group;
  }

  Future<void> createGroup({
    required String name,
    String? description,
    required String membershipType,
    String? banner,
    void Function(double progress)? onSendProgress,
  }) async {
    String? uploadedBanner;
    if (banner != null) {
      final urlResp =
          await dio.get('/v1/uploads', queryParameters: {'fileName': banner});
      await dio.put(
        urlResp.data['url'],
        data: File(banner).openRead(),
        options: Options(
          contentType: 'image/${banner.split(".").last}',
        ),
        onSendProgress: (count, total) => onSendProgress?.call(count / total),
      );
      uploadedBanner = urlResp.data['fileName'];
    }
    await dio.post(
      '/v1/groups',
      data: {
        'name': name,
        'description': description,
        'membershipType': membershipType,
        'banner': uploadedBanner,
      },
    );
  }

  Future<void> updateGroup({
    required String groupId,
    required String name,
    String? description,
    String? banner,
    void Function(double progress)? onSendProgress,
  }) async {
    String? uploadedBanner;
    if (banner != null && !banner.startsWith('https')) {
      final urlResp =
          await dio.get('/v1/uploads', queryParameters: {'fileName': banner});
      await dio.put(
        urlResp.data['url'],
        data: File(banner).openRead(),
        options: Options(
          contentType: 'image/${banner.split(".").last}',
        ),
        onSendProgress: (count, total) => onSendProgress?.call(count / total),
      );
      uploadedBanner = urlResp.data['fileName'];
    }
    await dio.put(
      '/v1/groups/$groupId',
      data: {
        'name': name,
        'description': description,
        'banner': uploadedBanner ?? '',
      }..removeWhere((_, value) => value?.startsWith('https') == true),
    );
  }

  Future<PaginationResponse<Group, String?>> fetchGroupsByUser(
      {required String uid, String? cursor}) async {
    try {
      final resp = await dio.get('/v1/groups/by/user/$uid', queryParameters: {
        'cursor': cursor,
      });
      return PaginationResponse(
        items: resp.data['data'] == null
            ? <Group>[]
            : List<Map<String, Object?>>.from(
                resp.data['data'],
              ).map((e) => Group.fromJson(e)).toList(),
        cursor: resp.data['cursor'],
      );
    } catch (e) {
      return PaginationResponse(
        items: null,
        cursor: null,
        error: e.toString(),
      );
    }
  }

  Future<PaginationResponse<Group, String?>> fetchGroups(
      {String? query, String? cursor, String? userId}) async {
    final resp = await dio.get('/v1/groups', queryParameters: {
      'query': query,
      'cursor': cursor,
      'userId': userId,
    });
    return PaginationResponse(
      items: resp.data['data'] == null
          ? <Group>[]
          : List<Map<String, Object?>>.from(
              resp.data['data'],
            ).map((e) => Group.fromJson(e)).toList(),
      cursor: resp.data['cursor'],
    );
  }

  Future<String?> joinGroup({
    required String groupId,
    required bool value,
  }) async {
    try {
      final resp = await dio
          .post('/v1/groups/$groupId/join', data: {'value': value.toString()});
      if (value) {
        return resp.data['data'];
      }
      return null;
    } on DioException catch (err) {
      if (err.response?.data['code'] == 'operation-not-allowed') {
        throw AdminLeaveGroupException();
      }
      rethrow;
    } catch (err) {
      rethrow;
    }
  }

  Future<Map> fetchGroupMembers({
    required String groupId,
    int? cursor,
    String type = 'members',
  }) async {
    final resp = await dio
        .get('/v1/groups/$groupId/$type', queryParameters: {'cursor': cursor});
    final members = resp.data['data'] == null
        ? null
        : List<Map<String, dynamic>>.from(resp.data['data'])
            .map((data) => GroupMember.fromJson(data))
            .toList();
    return {
      'cursor': resp.data['cursor'],
      'members': members,
    };
  }

  Future<void> acceptMember(
      {required String groupId, required String userId}) async {
    await dio.post('/v1/groups/$groupId/requests', data: {'userId': userId});
  }

  Future<void> promoteMember(
      {required String groupId, required String userId}) async {
    await dio.post('/v1/groups/$groupId/promote', data: {'userId': userId});
  }

  Future<void> removeGroup(String groupId) async {
    await dio.delete('/v1/groups/$groupId');
  }
}
