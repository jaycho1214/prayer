import 'package:applovin_max/applovin_max.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:prayer/app.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/firebase_options.dart';
import 'package:prayer/repo/authentication_repository.dart';
import 'package:prayer/repo/group_repository.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:prayer/repo/user_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  final List<Future<dynamic>> tasks = [];
  tasks.add(initialize());
  tasks.add(
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: MyTheme.surface,
  ));
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  GetIt.I.registerSingleton(AuthenticationRepository());
  GetIt.I.registerSingleton(UserRepository());
  GetIt.I.registerLazySingleton(() => GroupRepository());
  GetIt.I.registerLazySingleton(() => PrayerRepository());
  await Future.wait(tasks);
  if (kDebugMode) {
    runApp(ProviderScope(
      child: const App(),
    ));
  } else {
    await SentryFlutter.init(
      (options) {
        options.dsn = dotenv.env['SENTRY_DSN'];
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(ProviderScope(
        child: const App(),
      )),
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
