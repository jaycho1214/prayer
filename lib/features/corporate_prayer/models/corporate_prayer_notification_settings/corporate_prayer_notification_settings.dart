// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'corporate_prayer_notification_settings.freezed.dart';
part 'corporate_prayer_notification_settings.g.dart';

@Freezed()
class CorporatePrayerNotificationSettings
    with _$CorporatePrayerNotificationSettings {
  const factory CorporatePrayerNotificationSettings({
    @JsonKey(name: 'on_reminder') required bool onReminder,
    @JsonKey(name: 'on_post') required bool onPost,
  }) = _CorporatePrayerNotificationSettings;

  factory CorporatePrayerNotificationSettings.fromJson(
          Map<String, Object?> json) =>
      _$CorporatePrayerNotificationSettingsFromJson(json);
}
