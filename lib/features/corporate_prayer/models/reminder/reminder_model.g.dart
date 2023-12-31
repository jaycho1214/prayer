// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReminderImpl _$$ReminderImplFromJson(Map<String, dynamic> json) =>
    _$ReminderImpl(
      id: json['id'] as int,
      days: const DaysConverter().fromJson(json['days'] as String?),
      value: json['value'] as String,
      time: const TimeOfDayConverter().fromJson(json['time'] as String?),
      corporateId: json['corporate_id'] as String?,
      userId: json['user_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ReminderImplToJson(_$ReminderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'days': const DaysConverter().toJson(instance.days),
      'value': instance.value,
      'time': const TimeOfDayConverter().toJson(instance.time),
      'corporate_id': instance.corporateId,
      'user_id': instance.userId,
      'created_at': instance.createdAt?.toIso8601String(),
    };
