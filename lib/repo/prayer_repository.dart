import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:prayer/constants/dio.dart';
import 'package:prayer/model/corporate_prayer_model.dart';
import 'package:prayer/model/prayer_model.dart';
import 'package:prayer/model/prayer_pray_model.dart';

class PrayerRepository {
  Future<bool> createPrayer({
    required String value,
    String? groupId,
    String? corporateId,
    bool? anon,
    String? media,
    void Function(double progress)? onSendProgress,
  }) async {
    String? uploaded;
    if (media != null) {
      final urlResp =
          await dio.get('/v1/uploads', queryParameters: {'fileName': media});
      await dio.put(
        urlResp.data['url'],
        data: File(media).openRead(),
        options: Options(
          contentType: 'image/${media.split(".").last}',
        ),
        onSendProgress: (count, total) => onSendProgress?.call(count / total),
      );
      uploaded = urlResp.data['fileName'];
    }
    await dio.post('/v1/prayers', data: {
      'groupId': groupId,
      'corporateId': corporateId,
      'value': value,
      'anon': anon ?? false,
      'media': uploaded,
    });
    return true;
  }

  Future<bool> createCorporatePrayer({
    required String groupId,
    required String title,
    List<String> prayers = const [],
    String? description,
    DateTime? startedAt,
    DateTime? endedAt,
    void Function(double progress)? onSendProgress,
  }) async {
    await dio.post('/v1/prayers/corporate', data: {
      'groupId': groupId,
      'title': title,
      'description': description,
      'startedAt': startedAt?.toIso8601String(),
      'endedAt': endedAt?.toIso8601String(),
      'prayers': prayers.length == 0 ? null : jsonEncode(prayers),
    });
    return true;
  }

  Future<bool> deletePrayer({
    required String prayerId,
  }) async {
    await dio.delete('/v1/prayers/$prayerId');
    return true;
  }

  Future<bool> deleteCorporatePrayer({
    required String prayerId,
  }) async {
    await dio.delete('/v1/prayers/corporate/$prayerId');
    return true;
  }

  Future<bool> createPrayerPray({
    required String prayerId,
    String? value,
  }) async {
    final resp =
        await dio.post('/v1/prayers/$prayerId/pray', data: {'value': value});
    return resp.data['data'] == 'success';
  }

  Future<bool> deletePrayerPray({
    required String prayerId,
    required int prayId,
  }) async {
    final resp = await dio.delete('/v1/prayers/$prayerId/pray/$prayId');
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

  Future<Map> fetchPrayersFromCorporatePrayer(
      {required String prayerId, String? cursor}) async {
    final resp = await dio
        .get('/v1/prayers/corporate/$prayerId/prayers', queryParameters: {
      'cursor': cursor,
    });
    return resp.data;
  }

  Future<Map> fetchHomeFeed({String? cursor}) async {
    final resp = await dio.get('/v1/prayers', queryParameters: {
      'cursor': cursor,
    });
    return resp.data;
  }

  Future<Map> fetchUserPrayers({required String userId, String? cursor}) async {
    final resp = await dio.get('/v1/prayers/by/user/$userId', queryParameters: {
      'cursor': cursor,
    });
    return resp.data;
  }

  Future<Map> fetchGroupPrayersFromUser({String? cursor}) async {
    final resp = await dio.get('/v1/prayers/by/group', queryParameters: {
      'cursor': cursor,
    });
    return resp.data;
  }

  Future<Map> fetchGroupPrayers(
      {required String groupId, String? cursor}) async {
    final resp =
        await dio.get('/v1/prayers/by/group/$groupId', queryParameters: {
      'cursor': cursor,
    });
    return resp.data;
  }

  Future<Map> fetchGroupCoporatePrayers(
      {required String groupId, String? cursor}) async {
    final resp = await dio
        .get('/v1/prayers/corporate/by/group/$groupId', queryParameters: {
      'cursor': cursor,
    });
    return resp.data;
  }

  Future<Map> fetchPrayerPrays({required String prayerId, int? cursor}) async {
    final resp = await dio.get('/v1/prayers/$prayerId/pray', queryParameters: {
      'cursor': cursor,
    });
    return {
      'prays': List<Map<String, Object?>>.from(resp.data['data'])
          .map((e) => PrayerPray.fromJson(e))
          .toList(),
      'cursor': resp.data['cursor'],
    };
  }
}
