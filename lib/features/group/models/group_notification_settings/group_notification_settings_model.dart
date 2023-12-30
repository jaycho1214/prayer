// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_notification_settings_model.freezed.dart';
part 'group_notification_settings_model.g.dart';

@freezed
class GroupNotificationSettings with _$GroupNotificationSettings {
  const GroupNotificationSettings._();

  const factory GroupNotificationSettings({
    @JsonKey(name: 'on_moderator_post') required bool onModeratorPost,
    @JsonKey(name: 'on_post') required bool onPost,
  }) = _GroupNotificationSettings;

  factory GroupNotificationSettings.fromJson(Map<String, Object?> json) =>
      _$GroupNotificationSettingsFromJson(json);
}
