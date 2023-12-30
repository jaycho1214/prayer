import 'package:prayer/constants/dio.dart';
import 'package:prayer/features/corporate_prayer/models/corporate_prayer_notification_settings/corporate_prayer_notification_settings.dart';
import 'package:prayer/features/group/models/group_notification_settings/group_notification_settings_model.dart';
import 'package:prayer/features/group/models/group_member/group_member_model.dart';
import 'package:prayer/repo/response_types.dart';

class NotificationRepository {
  Future<DateTime?> fetchLatestNotificationDate() async {
    final resp = await dio.get('/v1/notifications/latest');
    final date =
        resp.data['data'] == null ? null : DateTime.parse(resp.data['data']);
    return date;
  }

  Future<PaginationResponse<GroupMember, int?>> fetchGroupMembers({
    required String groupId,
    String type = 'members',
    String? query,
    int? cursor,
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
      return PaginationResponse<GroupMember, int?>(
        items: [],
        error: err.toString(),
      );
    }
  }

  Future<GroupNotificationSettings?> fetchGroupNotificationSettings(
      String groupId) async {
    final resp = await dio.get('/v1/notifications/groups/$groupId');
    final data = resp.data['data'] == null
        ? null
        : GroupNotificationSettings.fromJson(resp.data['data']);
    return data;
  }

  Future<void> createGroupNotificationSettings(
      String groupId, GroupNotificationSettings value) async {
    await dio.post('/v1/notifications/groups/$groupId', data: {
      'onMemberPost': value.onPost,
      'onModeratorPost': value.onModeratorPost
    });
  }

  Future<CorporatePrayerNotificationSettings?>
      fetchCorporateNotificationSettings(String corporateId) async {
    final resp =
        await dio.get('/v1/notifications/prayers/corporate/$corporateId');
    final data = resp.data['data'] == null
        ? null
        : CorporatePrayerNotificationSettings.fromJson(resp.data['data']);
    return data;
  }

  Future<void> createCorporateNotificationSettings(
      String corporateId, CorporatePrayerNotificationSettings value) async {
    await dio.post('/v1/notifications/prayers/corporate/$corporateId', data: {
      'onMemberPost': value.onPost,
      'onReminder': value.onReminder,
    });
  }
}
