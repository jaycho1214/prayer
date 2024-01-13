import 'dart:io';

import 'package:dio/dio.dart';
import 'package:prayer/constants/dio.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/errors.dart';
import 'package:prayer/features/group/models/group_member/group_member_model.dart';
import 'package:prayer/features/group/models/group/group_model.dart';
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
    int? uploadedBanner;
    if (banner != null) {
      final urlResp =
          await dio.get('/v1/uploads', queryParameters: {'name': banner});
      await dio.put(
        urlResp.data['url'],
        data: File(banner).openRead(),
        options: Options(
          contentType: 'image/${banner.split(".").last}',
        ),
        onSendProgress: (count, total) => onSendProgress?.call(count / total),
      );
      uploadedBanner = urlResp.data['id'];
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
    mixpanel.track("Group Created", properties: {
      'name': name,
    });
  }

  Future<void> updateGroup({
    required String groupId,
    required String name,
    String? description,
    String? banner,
    void Function(double progress)? onSendProgress,
  }) async {
    int? uploadedBanner;
    if (banner != null && !banner.startsWith('https')) {
      final urlResp =
          await dio.get('/v1/uploads', queryParameters: {'name': banner});
      await dio.put(
        urlResp.data['url'],
        data: File(banner).openRead(),
        options: Options(
          contentType: 'image/${banner.split(".").last}',
        ),
        onSendProgress: (count, total) => onSendProgress?.call(count / total),
      );
      uploadedBanner = urlResp.data['id'];
    }
    await dio.put(
      '/v1/groups/$groupId',
      data: {
        'name': name,
        'description': description,
        'banner':
            banner?.startsWith('https') == true ? banner : uploadedBanner ?? '',
      }..removeWhere(
          (_, value) => value?.toString().startsWith('https') == true),
    );
    mixpanel.track("Group Updated");
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

  Future<PaginationResponse<Group, int?>> fetchInvitedGroups(
      {int? cursor}) async {
    try {
      final resp = await dio.get('/v1/groups/invitation', queryParameters: {
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
      if (value) {
        final resp = await dio.post('/v1/groups/$groupId/join');
        mixpanel.track("Group Joined");
        return resp.data['data'];
      } else {
        await dio.delete('/v1/groups/$groupId/join');
        mixpanel.track("Group Left");
        return null;
      }
    } on DioException catch (err) {
      if (err.response?.data['code'] == 'operation-not-allowed') {
        throw AdminLeaveGroupException();
      }
      rethrow;
    } catch (err) {
      rethrow;
    }
  }

  Future<void> inviteUserToGroup({
    required String groupId,
    required List<String> userIds,
    bool value = true,
  }) async {
    try {
      if (value) {
        await dio.post('/v1/groups/$groupId/invite', data: {
          'value': userIds,
        });
        mixpanel.track("Users Invited");
      } else {
        await dio.delete('/v1/groups/$groupId/invite', data: {
          'value': userIds,
        });
        mixpanel.track("Users Invited Undo");
      }
    } on DioException catch (err) {
      if (err.response?.data['code'] == 'operation-not-allowed') {
        throw NeedPermissionException();
      }
      rethrow;
    } catch (err) {
      rethrow;
    }
  }

  Future<void> kickUserFromGroup({
    required String groupId,
    required String userId,
  }) async {
    try {
      await dio.post('/v1/groups/$groupId/kick', data: {
        'userId': userId,
      });
      mixpanel.track("Users Kicked");
    } on DioException catch (err) {
      if (err.response?.data['code'] == 'operation-not-allowed') {
        throw NeedPermissionException();
      }
      rethrow;
    } catch (err) {
      rethrow;
    }
  }

  Future<PaginationResponse<GroupMember, String?>> fetchGroupMembers({
    required String groupId,
    String type = 'members',
    String? query,
    String? cursor,
  }) async {
    try {
      final resp = await dio.get(
        '/v1/groups/$groupId/$type',
        queryParameters: {
          'cursor': cursor,
          'query': query,
        },
      );
      final members = resp.data['data'] == null
          ? null
          : List<Map<String, dynamic>>.from(resp.data['data'])
              .map((data) => GroupMember.fromJson(data))
              .toList();
      return PaginationResponse(
        items: members,
        cursor: resp.data['cursor'],
      );
    } catch (err) {
      return PaginationResponse<GroupMember, String?>(
        items: [],
        error: err.toString(),
      );
    }
  }

  Future<PaginationResponse<GroupMember, String?>> fetchGroupInvites({
    required String groupId,
    String? cursor,
    String? query,
  }) async {
    try {
      final resp = await dio.get(
        '/v1/groups/$groupId/invites',
        queryParameters: {
          'cursor': cursor == null ? null : int.tryParse(cursor),
          'query': query,
        },
      );
      final members = resp.data['data'] == null
          ? null
          : List<Map<String, dynamic>>.from(resp.data['data'])
              .map((data) => GroupMember.fromJson(data))
              .toList();
      return PaginationResponse(
        items: members,
        cursor: resp.data['cursor'],
      );
    } catch (err) {
      return PaginationResponse<GroupMember, String?>(
        items: [],
        error: err.toString(),
      );
    }
  }

  Future<PaginationResponse<GroupMember, String?>> fetchGroupBans({
    required String groupId,
    String? cursor,
    String? query,
  }) async {
    try {
      final resp = await dio.get(
        '/v1/groups/$groupId/bans',
        queryParameters: {
          'cursor': cursor == null ? null : int.tryParse(cursor),
          'query': query,
        },
      );
      final members = resp.data['data'] == null
          ? null
          : List<Map<String, dynamic>>.from(resp.data['data'])
              .map((data) => GroupMember.fromJson(data))
              .toList();
      return PaginationResponse(
        items: members,
        cursor: resp.data['cursor'],
      );
    } catch (err) {
      return PaginationResponse<GroupMember, String?>(
        items: [],
        error: err.toString(),
      );
    }
  }

  Future<void> acceptMember(
      {required String groupId, required String userId}) async {
    await dio.post('/v1/groups/$groupId/requests',
        data: {'userId': userId, 'value': true});
  }

  Future<void> promoteMember({
    required String groupId,
    required String userId,
    required bool value,
  }) async {
    if (value) {
      await dio.post('/v1/groups/$groupId/promote', data: {'userId': userId});
    } else {
      await dio.delete('/v1/groups/$groupId/promote', data: {'userId': userId});
    }
  }

  Future<void> banMember({
    required String groupId,
    required String userId,
    required bool value,
  }) async {
    if (value) {
      await dio.post('/v1/groups/$groupId/bans', data: {'userId': userId});
    } else {
      await dio.delete('/v1/groups/$groupId/bans', data: {'userId': userId});
    }
  }

  Future<void> removeGroup(String groupId) async {
    await dio.delete('/v1/groups/$groupId');
    mixpanel.track("Group Removed");
  }
}
