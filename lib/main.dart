import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:prayer/app.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/theme.dart';
import 'package:prayer/firebase_options.dart';
import 'package:prayer/repo/authentication_repository.dart';
import 'package:prayer/repo/bible_repository.dart';
import 'package:prayer/repo/group_repository.dart';
import 'package:prayer/repo/notification_repository.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:prayer/repo/user_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  final futureFns = {
    'init': initialize(),
    'firebase':
        Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    'sharedPref': SharedPreferences.getInstance(),
  };
  PhotoManager.clearFileCache();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: MyTheme.surface,
  ));
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  GetIt.I.registerSingleton(AuthenticationRepository());
  GetIt.I.registerSingleton(UserRepository());
  GetIt.I.registerLazySingleton(() => GroupRepository());
  GetIt.I.registerLazySingleton(() => NotificationRepository());
  GetIt.I.registerLazySingleton(() => PrayerRepository());
  GetIt.I.registerLazySingleton(() => BibleRepository());
  final pref = await (futureFns['sharedPref'] as Future<SharedPreferences>);
  GetIt.I.registerLazySingleton(() => pref);
  await Future.wait(futureFns.values.toList());
  Intl.defaultLocale = Intl.systemLocale;
  await SentryFlutter.init(
    (options) {
      options.dsn = kDebugMode ? '' : dotenv.env['SENTRY_DSN'];
      options.tracesSampleRate = 0.5;
    },
    appRunner: () => runApp(ProviderScope(
      child: SentryUserInteractionWidget(child: const App()),
    )),
  );
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

Future<void> initialize() async {
  await dotenv.load();
  mixpanel = await Mixpanel.init(
    dotenv.env['MIXPANEL_TOKEN']!,
    trackAutomaticEvents: true,
    optOutTrackingDefault: kDebugMode,
  );
}
