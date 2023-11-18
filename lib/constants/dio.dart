import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:prayer/constants/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

final options = CacheOptions(
  store: MemCacheStore(),
  policy: CachePolicy.request,
  hitCacheOnErrorExcept: [401, 403],
  maxStale: const Duration(days: 1),
  priority: CachePriority.normal,
);
final dio = Dio(BaseOptions(
  baseUrl: kDebugMode
      ? 'https://rare-humorous-muskox.ngrok-free.app'
      : 'https://api-prayer.crosswand.com',
))
  ..interceptors.add(DioCacheInterceptor(options: options))
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      options.headers['X-Timezone-Offset'] =
          DateTime.now().timeZoneOffset.inHours;
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      talker.debug('New Id Token Fetched: $token');
      if (token != null) {
        options.headers['authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
  ))
  ..interceptors.add(TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
    printRequestData: false,
    printResponseMessage: false,
    printRequestHeaders: false,
    printResponseData: true,
  )));
