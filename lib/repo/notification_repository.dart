import 'package:prayer/constants/dio.dart';
import 'package:prayer/model/group_member/group_member_model.dart';
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
}
