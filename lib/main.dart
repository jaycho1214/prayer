import 'dart:convert';

import 'package:applovin_max/applovin_max.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:prayer/app.dart';
import 'package:prayer/constants/cache_storage.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/firebase_options.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  final List<Future<dynamic>> tasks = [];
  tasks.add(initHydratedBloc());
  tasks.add(initialize());
  tasks.add(
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: MyTheme.surface,
  ));
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await Future.wait(tasks);
  if (kDebugMode) {
    runApp(const App());
  } else {
    await SentryFlutter.init(
      (options) {
        options.dsn = dotenv.env['SENTRY_DSN'];
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(const App()),
    );
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  talker.debug("Message fetched on background $message");
}

Future<void> initialize() async {
  await dotenv.load();
  final [mp, _] = await Future.wait([
    Mixpanel.init(
      dotenv.env['MIXPANEL_TOKEN']!,
      trackAutomaticEvents: true,
    ),
    AppLovinMAX.initialize(dotenv.env['APPLOVIN_SDK_KEY']!),
  ]);
  mixpanel = mp as Mixpanel;
}

Future<void> initHydratedBloc() async {
  await Hive.initFlutter();
  final cacheEncryptionKey =
      await const FlutterSecureStorage().read(key: 'cache_encryption_key');
  late final List<int> encryptionKey;
  if (cacheEncryptionKey == null) {
    encryptionKey = Hive.generateSecureKey();
    const FlutterSecureStorage().write(
      key: 'cache_encryption_key',
      value: base64Url.encode(encryptionKey),
    );
  } else {
    encryptionKey = base64Url.decode(cacheEncryptionKey);
  }
  final encryptionCipher = HiveAesCipher(encryptionKey);
  final blocHive = await Hive.openBox(
    'cache_bloc',
    encryptionCipher: encryptionCipher,
  );
  HydratedBloc.storage = HydratedCacheStorage(blocHive);
}
