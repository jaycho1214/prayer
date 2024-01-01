import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/features/common/widgets/notification_bar.dart';
import 'package:prayer/features/settings/reminders/models/local_reminder.dart';
import 'package:prayer/utils/app_link.dart';
import 'package:prayer/utils/local_reminder.dart';
import 'package:prayer/utils/notification.dart';

void useNotifications(BuildContext context) {
  final result = useState<bool>(false);

  useEffect(() {
    initializeNotification(context)
        .then((value) => result.value = value ?? false);
    return () => null;
  }, []);

  useEffect(() {
    List<StreamSubscription<dynamic>> subscriptions = [];
    subscriptions.add(FirebaseMessaging.onMessage.listen((initialMessage) {
      talker.debug("[Notification] Foreground Notification Detected");
      final body = buildNotification(initialMessage);
      if (body != null) {
        NotificationSnackBar.show(
          context,
          message: body.body,
          onTap: () => handleForegroundNotification(context, initialMessage),
        );
      }
    }));
    subscriptions.add(AppLinks()
        .allUriLinkStream
        .listen((uri) => handleAppLink(context, uri)));
    return () {
      subscriptions.forEach((subscription) => subscription.cancel());
    };
  }, []);

  useEffect(() {
    if (!result.value) {
      return () => null;
    }
    final box = Hive.box<LocalReminder>('local_reminders');
    final listenable = box.listenable();
    refreshLocalReminders();
    final fn = () => refreshLocalReminders();
    listenable.addListener(fn);
    return () => listenable.removeListener(fn);
  }, [result.value]);

  useValueChanged<bool, dynamic>(result.value, (_, __) {
    if (!result.value) {
      return;
    }
    FlutterLocalNotificationsPlugin()
        .getNotificationAppLaunchDetails()
        .then((response) => handleNotificationAppLaunch(context, response));
  });
}
