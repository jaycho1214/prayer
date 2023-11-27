import 'package:get_it/get_it.dart';
import 'package:jiffy/jiffy.dart';
import 'package:prayer/repo/notification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'notification_provider.g.dart';

@riverpod
class NotificationNotifier extends _$NotificationNotifier {
  @override
  FutureOr<bool> build() async {
    final data =
        await GetIt.I<NotificationRepository>().fetchLatestNotificationDate();
    final prefs = GetIt.I<SharedPreferences>();
    if (data == null) {
      return false;
    }
    final latestReadDateString =
        prefs.getString('notification.latest_read_date');
    if (latestReadDateString == null) {
      return true;
    }
    final latestReadDate = Jiffy.parse(latestReadDateString);
    return Jiffy.parseFromDateTime(data).isSameOrAfter(latestReadDate);
  }

  void readNow() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(
          'notification.latest_read_date', DateTime.now().toIso8601String());
    });
    state = AsyncValue.data(false);
  }
}
