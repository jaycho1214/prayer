import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:prayer/constants/dio.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/features/settings/notifications/models/notification_model.dart';
import 'package:prayer/i18n/strings.g.dart';
import 'package:prayer/main.dart';
import 'package:prayer/repo/prayer_repository.dart';

class NotificationBody {
  const NotificationBody({
    required this.title,
    required this.body,
  });
  final String title;
  final String body;
}

Future<bool?> initializeNotification(BuildContext context) async {
  try {
    final status = await FlutterLocalNotificationsPlugin().initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          notificationCategories: [
            DarwinNotificationCategory(
              'prayer_posted',
              actions: [
                DarwinNotificationAction.plain('pray', 'Pray'),
                DarwinNotificationAction.text(
                  'pray_with_comment',
                  'Pray with comment',
                  buttonTitle: 'Pray',
                  placeholder: 'Amen',
                  options: {
                    DarwinNotificationActionOption.authenticationRequired,
                  },
                ),
              ],
            ),
            DarwinNotificationCategory(
              'reminder_post_prayer',
              actions: [
                DarwinNotificationAction.text(
                  'pray_with_comment',
                  'Post Prayer',
                  buttonTitle: 'Post',
                  placeholder: 'Amen',
                  options: {
                    DarwinNotificationActionOption.foreground,
                  },
                ),
              ],
            ),
          ],
          onDidReceiveLocalNotification: (id, title, body, payload) => null,
        ),
      ),
      onDidReceiveBackgroundNotificationResponse: handleNotificationResponse,
      onDidReceiveNotificationResponse: (response) =>
          innerHandleNotification(response, context),
    );
    await FirebaseMessaging.instance.requestPermission(provisional: false);
    talker.debug(generateLogMessage("[Notification] Permission updated", data: {
      "status": status,
    }));
    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    if (Platform.isIOS && apnsToken != null || Platform.isAndroid) {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        talker.debug(generateLogMessage("[Notification] Fcm Token Refreshed",
            data: {"fcmToken": fcmToken}));
        await dio.post('/v1/users/fcmToken', data: {'value': fcmToken});
        talker.good('[Notification] Fcm Token Updated');
      }
    }
    return status;
  } catch (e, st) {
    talker.handle(e, st, "[Notification] Failed to update");
    return null;
  }
}

Future<void> handleNotificationAppLaunch(
    BuildContext context, NotificationAppLaunchDetails? detail) async {
  if (detail?.didNotificationLaunchApp != true) {
    return;
  }
  if (detail!.notificationResponse != null) {
    innerHandleNotification(detail.notificationResponse!, context);
  }
}

Future<void> innerHandleNotification(
    NotificationResponse response, BuildContext? context) async {
  talker.debug(generateLogMessage('[ForegroundNotification] Received', data: {
    'id': response.id,
    'actionId': response.actionId,
    'input': response.input,
    'payload': response.payload
  }));
  if (response.payload == '/form/prayer' && context != null) {
    context.push(
        Uri(path: '/form/prayer', queryParameters: {'value': response.input})
            .toString());
  }
  final uri = Uri.parse(response.payload!);
  if (uri.pathSegments.length < 2) {
    return;
  }
  if (uri.pathSegments[0] == 'prayers') {
    if (uri.pathSegments[1] == 'corporate') {
      if (context != null) {
        context.push('/prayers/${uri.pathSegments[2]}');
      }
      return;
    }
    final repository = PrayerRepository();
    if (response.actionId == "pray") {
      await repository.createPrayerPray(prayerId: uri.pathSegments[1]);
    } else if (response.actionId == "pray_with_comment" &&
        (response.input?.trim() ?? '') != '') {
      await repository.createPrayerPray(
          prayerId: uri.pathSegments[1], value: response.input!);
    }
    if (context != null) {
      context.push('/prayers/${uri.pathSegments[1]}');
    }
  } else if (uri.pathSegments[0] == 'groups') {
    if (context != null) {
      context.push('/groups/${uri.pathSegments[1]}');
    }
  } else if (uri.pathSegments[0] == 'users') {
    if (context != null) {
      context.push(
          Uri(path: '/users', queryParameters: {'uid': uri.pathSegments[1]})
              .toString());
    }
  }
}

String? buildThreadIdentifier(RemoteMessage? message) {
  if (message == null) {
    return null;
  }
  final data = message.data;
  if (data['prayerId'] != null) {
    return '/prayers/${data["prayerId"]}';
  } else if (data['corporateId'] != null) {
    return '/prayers/corporate/${data["corporateId"]}';
  } else if (data['groupId'] != null) {
    return '/groups/:${data["groupId"]}';
  } else if (data['userId'] != null) {
    return '/users?uid=:${data["userId"]}';
  }
  return null;
}

NotificationBody? buildNotification(RemoteMessage? message) {
  if (message == null) {
    return null;
  }
  if (message.data['type'] == null) {
    return null;
  }
  return switch (NotificationType.values.byName(message.data['type'])) {
    NotificationType.followed => NotificationBody(
        title: 'Prayer',
        body: t.notification.plain
            .someoneFollowed(username: message.data['username']),
      ),
    NotificationType.group_join_requested => NotificationBody(
        title: message.data['groupName'],
        body: t.notification.plain
            .groupJoinRequested(username: message.data['username']),
      ),
    NotificationType.group_joined => NotificationBody(
        title: message.data['groupName'],
        body: t.notification.plain
            .someoneJoinedGroup(username: message.data['username']),
      ),
    NotificationType.group_accepted => NotificationBody(
        title: message.data['groupName'],
        body: t.notification.plain
            .groupAccepted(group: message.data['groupName']),
      ),
    NotificationType.group_promoted => NotificationBody(
        title: message.data['groupName'],
        body: t.notification.plain
            .groupPromoted(group: message.data['groupName']),
      ),
    NotificationType.prayed => NotificationBody(
        title: 'Prayer',
        body: t.notification.plain.prayed(username: message.data['username']),
      ),
    NotificationType.prayer_posted => NotificationBody(
        title: 'Prayer',
        body: t.notification.plain
            .postedPrayer(username: message.data['username']),
      ),
    NotificationType.group_corporate_posted => NotificationBody(
        title: message.data['groupName'],
        body: t.notification.plain
            .postedCorporatePrayer(username: message.data['username']),
      ),
  };
}

void handleForegroundNotification(
    BuildContext context, RemoteMessage? message) {
  if (message == null) {
    return;
  }
  talker.debug("[Notification] Received Notification, $message");
  final data = message.data;
  if (data['prayerId'] != null) {
    context.push('/prayers/${data["prayerId"]}');
  } else if (data['corporateId'] != null) {
    context.push('/prayers/corporateId/${data["corporateId"]}');
  } else if (data['groupId'] != null) {
    context.push('/groups/${data["groupId"]}');
  } else if (data['userId'] != null) {
    context.push(Uri(path: '/users', queryParameters: {'uid': data['userId']})
        .toString());
  }
}
