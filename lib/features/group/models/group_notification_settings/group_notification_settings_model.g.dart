// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_notification_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupNotificationSettingsImpl _$$GroupNotificationSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$GroupNotificationSettingsImpl(
      onModeratorPost: json['on_moderator_post'] as bool,
      onPost: json['on_post'] as bool,
    );

Map<String, dynamic> _$$GroupNotificationSettingsImplToJson(
        _$GroupNotificationSettingsImpl instance) =>
    <String, dynamic>{
      'on_moderator_post': instance.onModeratorPost,
      'on_post': instance.onPost,
    };
