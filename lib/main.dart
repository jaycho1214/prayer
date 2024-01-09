import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:prayer/app.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/features/settings/reminders/models/local_reminder.dart';
import 'package:prayer/firebase_options.dart';
import 'package:prayer/repo/authentication_repository.dart';
import 'package:prayer/repo/bible_repository.dart';
import 'package:prayer/repo/group_repository.dart';
import 'package:prayer/repo/notification_repository.dart';
import 'package:prayer/repo/prayer_repository.dart';
import 'package:prayer/repo/user_repository.dart';
import 'package:prayer/utils/hive_adapters.dart';
import 'package:prayer/utils/notification.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

Future<void> main() async {
  final Map<String, Future<dynamic>> futureFns = {
    'hive': initializeHive(),
    'init': initialize(),
    'firebase':
        Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    'timezone': initializeTimeZone(),
  };
  PhotoManager.clearFileCache();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  GetIt.I.registerSingleton(AuthenticationRepository());
  GetIt.I.registerSingleton(UserRepository());
  GetIt.I.registerLazySingleton(() => GroupRepository());
  GetIt.I.registerLazySingleton(() => NotificationRepository());
  GetIt.I.registerLazySingleton(() => PrayerRepository());
  GetIt.I.registerLazySingleton(() => BibleRepository());
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
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final messageBody = buildNotification(message);
  if (messageBody == null) {
    return;
  }
  FlutterLocalNotificationsPlugin().show(
    DateTime.now().millisecondsSinceEpoch,
    messageBody.title,
    messageBody.body,
    NotificationDetails(
      android: switch (message.data['type']) {
        'prayer_posted' => AndroidNotificationDetails(
            'prayer_posted',
            'Channels for Prayers',
          ),
        _ => AndroidNotificationDetails('notification', 'Default Channel'),
      },
      iOS: DarwinNotificationDetails(
        categoryIdentifier: switch (message.data['type']) {
          'prayer_posted' => 'prayer_posted',
          _ => null,
        },
        threadIdentifier: buildThreadIdentifier(message),
      ),
    ),
    payload: buildThreadIdentifier(message),
  );
}

@pragma('vm:entry-point')
Future<void> handleNotificationResponse(NotificationResponse response) async {
  if (response.payload == null) {
    return;
  }
  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    dotenv.load(),
  ]);
  innerHandleNotification(response, null);
}

Future<void> initializeTimeZone() async {
  tz.initializeTimeZones();
  final location = tz.getLocation(await FlutterTimezone.getLocalTimezone());
  tz.setLocalLocation(location);
}

Future<void> initializeHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(LocalReminderAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  await Hive.openBox('settings');
  await Hive.openBox<LocalReminder>('local_reminders');
}

Future<void> initialize() async {
  await dotenv.load();
  mixpanel = await Mixpanel.init(
    dotenv.env['MIXPANEL_TOKEN']!,
    trackAutomaticEvents: true,
    optOutTrackingDefault: kDebugMode,
  );
}
