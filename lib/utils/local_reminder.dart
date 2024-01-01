import 'package:prayer/constants/talker.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prayer/features/settings/reminders/models/local_reminder.dart';

Future<void> refreshLocalReminders() async {
  final plugin = FlutterLocalNotificationsPlugin();
  final box = Hive.box<LocalReminder>('local_reminders');
  final reminders = box.values.toList();
  await plugin.cancelAll();
  if (reminders.length == 0) {
    return;
  }
  int count = 0;
  final now = tz.TZDateTime.now(tz.local);
  for (int offset = 0; offset < 365 && count < 50; offset++) {
    final pointer = now.add(Duration(days: offset));
    final todayReminders = reminders
        .where((element) => element.days.indexOf(pointer.weekday) != -1)
        .toList();
    for (LocalReminder element in todayReminders) {
      if (count > 50) {
        return;
      }
      final adjusted = tz.TZDateTime(
        tz.local,
        pointer.year,
        pointer.month,
        pointer.day,
        element.time.hour,
        element.time.minute,
      );
      if (now.isBefore(adjusted)) {
        await plugin.zonedSchedule(
          1000 + count,
          element.title,
          element.body,
          adjusted,
          const NotificationDetails(
            iOS: DarwinNotificationDetails(
                categoryIdentifier: 'reminder_post_prayer'),
            android: AndroidNotificationDetails(
              'reminder_post_prayer',
              'Reminders to pray',
            ),
          ),
          payload: '/form/prayer',
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
        talker.debug(
            '[LocalReminder] reminder sets at ${adjusted.toIso8601String()} $count/50');
        count++;
      }
    }
  }
}
