import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/constants/dio.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/model/corporate_prayer/corporate_prayer_model.dart';
import 'package:prayer/features/prayer/models/prayer_model.dart';
import 'package:prayer/model/prayer_pray/prayer_pray_model.dart';
import 'package:prayer/repo/response_types.dart';

class PrayerRepository {
  Future<bool> createPrayer({
    required String value,
    String? groupId,
    String? corporateId,
    bool? anon,
    List<String>? media,
    List<int>? verses,
    void Function(double progress)? onSendProgress,
  }) async {
    List<int> uploaded = [];
    if (media != null && media.length > 0) {
      final urlResp = await dio
          .get('/v1/uploads/multiple', queryParameters: {'name': media});
      await Future.wait((urlResp.data['data'] as List<dynamic>)
          .asMap()
          .entries
          .map((d) => () async {
                await dio.put(
                  d.value['url'],
                  data: File(media[d.key]).openRead(),
                  options: Options(
                    contentType: 'image/${media[d.key].split(".").last}',
                  ),
                  onSendProgress: (count, total) =>
                      onSendProgress?.call(count / total),
                );
                uploaded.add(d.value['id']);
              }()));
    }
    await dio.post('/v1/prayers', data: {
      'groupId': groupId,
      'corporateId': corporateId,
      'value': value,
      'anon': anon ?? false,
      'contents': uploaded,
      'verses': verses,
    });
    mixpanel.track("Prayer Created", properties: {
      'groupId': groupId,
      'corporateId': corporateId,
      'value': value,
      'anon': anon ?? false,
      'contents': uploaded,
      'verses': verses,
    });
    return true;
  }

  Future<bool> createOrUpdateCorporatePrayer({
    String? corporateId,
    required String groupId,
    required String title,
    List<String> prayers = const [],
    String? description,
    DateTime? startedAt,
    DateTime? endedAt,
    DateTime? reminderTime,
    String? reminderText,
    List<int>? reminderDays,
    void Function(double progress)? onSendProgress,
  }) async {
    await dio.post('/v1/prayers/corporate', data: {
      'corporateId': corporateId,
      'groupId': groupId,
      'title': title,
      'description': description,
      'startedAt': startedAt?.toIso8601String(),
      'endedAt': endedAt?.toIso8601String(),
      'prayers': prayers,
      'reminderTime': reminderTime?.toLocal() == null
          ? null
          : Jiffy.parseFromDateTime(reminderTime!.toLocal().copyWith(
                second: 0,
                microsecond: 0,
                millisecond: 0,
              )).Hms,
      'reminderText': reminderText,
      'reminderDays': reminderDays,
    });
    mixpanel.track("Corporate Prayer Created", properties: {
      'groupId': groupId,
      'corporateId': corporateId,
      'title': title,
      'description': description,
    });
    return true;
  }

  Future<bool> deletePrayer({
    required String prayerId,
  }) async {
    await dio.delete('/v1/prayers/$prayerId');
    mixpanel.track("Prayer Deleted");
    return true;
  }

  Future<bool> deleteCorporatePrayer({
    required String prayerId,
  }) async {
    await dio.delete('/v1/prayers/corporate/$prayerId');
    mixpanel.track("Corporate Prayer Deleted");
    return true;
  }

  Future<bool> createPrayerPray({
    required String prayerId,
    String? value,
  }) async {
    final resp = await dio
        .post('/v1/prayers/pray', data: {'prayerId': prayerId, 'value': value});
    mixpanel.track("Pray Created");
    return resp.data['data'] == 'success';
  }

  Future<bool> deletePrayerPray({
    required String prayerId,
    required int prayId,
  }) async {
    final resp = await dio.delete('/v1/prayers/pray/$prayId');
    mixpanel.track("Pray Deleted");
    return resp.data['data'] == 'success';
  }

  Future<Prayer?> fetchPrayer(String prayerId) async {
    final resp = await dio.get('/v1/prayers/$prayerId');
    if (resp.data['message'] != null) {
      throw resp.data['message'];
    }
    final prayer =
        resp.data['data'] == null ? null : Prayer.fromJson(resp.data['data']);
    return prayer;
  }

  Future<CorporatePrayer?> fetchCorporatePrayer(String prayerId) async {
    final resp = await dio.get('/v1/prayers/corporate/$prayerId');
    if (resp.data['message'] != null) {
      throw resp.data['message'];
    }
    final prayer = resp.data['data'] == null
        ? null
        : CorporatePrayer.fromJson(resp.data['data']);
    return prayer;
  }

  Future<PaginationResponse<String, CursorType?>>
      fetchPrayerPagination<CursorType>(String url, CursorType? cursor) async {
    final resp = await dio.get(url, queryParameters: {
      'cursor': cursor,
    });
    return PaginationResponse(
      items: List<String>.from(resp.data['data']),
      cursor: resp.data['cursor'],
    );
  }

  Future<PaginationResponse<String, String?>> fetchPrayersFromCorporatePrayer(
      {required String prayerId, String? cursor}) async {
    return fetchPrayerPagination(
        '/v1/prayers/corporate/$prayerId/prayers', cursor);
  }

  Future<PaginationResponse<String, String?>> fetchHomeFeed(
      {String? cursor}) async {
    return fetchPrayerPagination('/v1/prayers', cursor);
  }

  Future<PaginationResponse<String, String?>> fetchFollowersPrayers(
      {String? cursor}) async {
    return fetchPrayerPagination('/v1/prayers/followers', cursor);
  }

  Future<PaginationResponse<String, String?>> fetchNeighborPrayers(
      {String? cursor}) async {
    return fetchPrayerPagination('/v1/prayers/neighbor', cursor);
  }

  Future<PaginationResponse<String, String?>> fetchUserPrayers(
      {required String userId, String? cursor}) async {
    return fetchPrayerPagination('/v1/prayers/by/user/$userId', cursor);
  }

  Future<PaginationResponse<String, String?>> fetchGroupPrayersFromUser(
      {String? cursor}) async {
    return fetchPrayerPagination('/v1/prayers/by/group', cursor);
  }

  Future<PaginationResponse<String, String?>> fetchGroupPrayers({
    required String groupId,
    String? cursor,
  }) async {
    return fetchPrayerPagination('/v1/prayers/by/group/$groupId', cursor);
  }

  Future<PaginationResponse<String, String?>> fetchGroupCoporatePrayers(
      {required String groupId, String? cursor}) async {
    return fetchPrayerPagination(
        '/v1/prayers/corporate/by/group/$groupId', cursor);
  }

  Future<PaginationResponse<String, String?>> fetchPrayerPrayedByUser(
      {required String userId, String? cursor}) async {
    return fetchPrayerPagination('/v1/prayers/pray/by/user/$userId', cursor);
  }

  Future<PaginationResponse<PrayerPray, int?>> fetchPrayerPrays(
      {required String prayerId, int? cursor}) async {
    final resp =
        await dio.get('/v1/prayers/pray/by/prayer/$prayerId', queryParameters: {
      'cursor': cursor,
    });
    return PaginationResponse(
      items: List<Map<String, Object?>>.from(resp.data['data'])
          .map((e) => PrayerPray.fromJson(e))
          .toList(),
      cursor: resp.data['cursor'],
    );
  }
}
