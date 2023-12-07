// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_prayer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporatePrayerImpl _$$CorporatePrayerImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporatePrayerImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      user: json['user'] == null
          ? null
          : PUser.fromJson(json['user'] as Map<String, dynamic>),
      group: json['group'] == null
          ? null
          : Group.fromJson(json['group'] as Map<String, dynamic>),
      groupId: json['group_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      reminder: json['reminder'] == null
          ? null
          : Reminder.fromJson(json['reminder'] as Map<String, dynamic>),
      prayers:
          const CorporatePrayerConverter().fromJson(json['prayers'] as String?),
      prayersCount: json['prayers_count'] as int? ?? 0,
      startedAt: json['started_at'] == null
          ? null
          : DateTime.parse(json['started_at'] as String),
      endedAt: json['ended_at'] == null
          ? null
          : DateTime.parse(json['ended_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$CorporatePrayerImplToJson(
        _$CorporatePrayerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'user': instance.user,
      'group': instance.group,
      'group_id': instance.groupId,
      'title': instance.title,
      'description': instance.description,
      'reminder': instance.reminder,
      'prayers': const CorporatePrayerConverter().toJson(instance.prayers),
      'prayers_count': instance.prayersCount,
      'started_at': instance.startedAt?.toIso8601String(),
      'ended_at': instance.endedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
