import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/repo/notification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_provider.g.dart';

@riverpod
class NotificationNotifier extends _$NotificationNotifier {
  @override
  FutureOr<bool> build() async {
    try {
      final data =
          await GetIt.I<NotificationRepository>().fetchLatestNotificationDate();
      if (data == null) {
        return false;
      }
      final latestReadDateString =
          await Hive.box('settings').get('notification.latest_read_date');
      if (latestReadDateString == null) {
        return true;
      }
      final latestReadDate = Jiffy.parse(latestReadDateString);
      return Jiffy.parseFromDateTime(data).isSameOrAfter(latestReadDate);
    } catch (e, st) {
      talker.handle(
          e, st, "[Notification] Failed to fetch latest notification date");
      return false;
    }
  }

  void readNow() {
    Hive.box('settings')
        .put('notification.latest_read_date', DateTime.now().toIso8601String());
    state = AsyncValue.data(false);
  }
}
