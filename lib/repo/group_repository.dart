import 'dart:io';

import 'package:dio/dio.dart';
import 'package:prayer/constants/dio.dart';
import 'package:prayer/model/group_member_model.dart';
import 'package:prayer/model/group_model.dart';

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

  Future<Map> fetchGroupsByUser({required String uid, String? cursor}) async {
    final resp = await dio.get('/v1/groups/by/user/$uid', queryParameters: {
      'cursor': cursor,
    });
    return resp.data;
  }

  Future<Map> fetchGroups(
      {String? query, String? cursor, String? userId}) async {
    final resp = await dio.get('/v1/groups', queryParameters: {
      'query': query,
      'cursor': cursor,
      'userId': userId,
    });
    return resp.data;
  }

  Future<Map> joinGroup({
    required String groupId,
    required bool value,
  }) async {
    final resp = await dio
        .post('/v1/groups/$groupId/join', data: {'value': value.toString()});
    return resp.data;
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

  Future<bool> acceptMember(
      {required String groupId, required String userId}) async {
    await dio.post('/v1/groups/$groupId/requests', data: {'userId': userId});
    return true;
  }

  Future<bool> promoteMember(
      {required String groupId, required String userId}) async {
    await dio.post('/v1/groups/$groupId/promote', data: {'userId': userId});
    return true;
  }

  Future<bool> removeGroup(String groupId) async {
    await dio.delete('/v1/groups/$groupId');
    return true;
  }
}
