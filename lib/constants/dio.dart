import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

final dio = Dio(BaseOptions(
  baseUrl: kDebugMode
      ? 'https://4808-121-167-40-227.ngrok-free.app'
      : 'https://api-prayer.crosswand.com',
))
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      options.headers['X-Timezone'] = DateTime.now().timeZoneName;
      options.headers['X-Timezone-Offset'] =
          DateTime.now().timeZoneOffset.inMinutes;
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (token != null) {
        options.headers['authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
  ));
