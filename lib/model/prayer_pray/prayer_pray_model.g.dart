// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_pray_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PrayerPrayImpl _$$PrayerPrayImplFromJson(Map<String, dynamic> json) =>
    _$PrayerPrayImpl(
      user: PUser.fromJson(json['user'] as Map<String, dynamic>),
      id: json['id'] as int,
      value: json['value'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$PrayerPrayImplToJson(_$PrayerPrayImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'id': instance.id,
      'value': instance.value,
      'created_at': instance.createdAt.toIso8601String(),
    };
