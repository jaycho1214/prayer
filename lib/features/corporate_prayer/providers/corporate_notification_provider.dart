import 'package:get_it/get_it.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/features/corporate_prayer/models/corporate_prayer_notification_settings/corporate_prayer_notification_settings.dart';
import 'package:prayer/repo/notification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'corporate_notification_provider.g.dart';

@riverpod
class CorporateNotificationNotifier extends _$CorporateNotificationNotifier {
  @override
  FutureOr<CorporatePrayerNotificationSettings> build(
      String corporateId) async {
    try {
      final data = await GetIt.I<NotificationRepository>()
          .fetchCorporateNotificationSettings(corporateId);
      return data ??
          CorporatePrayerNotificationSettings(
            onReminder: false,
            onPost: false,
          );
    } catch (error, stackTrace) {
      talker.handle(
          error,
          stackTrace,
          generateLogMessage('[CorproateNotification] Failed to fetch', data: {
            'corporateId': corporateId,
          }));
      return CorporatePrayerNotificationSettings(
        onReminder: false,
        onPost: false,
      );
    }
  }

  Future<void> updateSettings(
      CorporatePrayerNotificationSettings newValue) async {
    await GetIt.I<NotificationRepository>()
        .createCorporateNotificationSettings(corporateId, newValue);
    state = AsyncValue.data(newValue);
  }
}
