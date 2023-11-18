// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PrayerImpl _$$PrayerImplFromJson(Map<String, dynamic> json) => _$PrayerImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String?,
      user: json['user'] == null
          ? null
          : PUser.fromJson(json['user'] as Map<String, dynamic>),
      group: json['group'] == null
          ? null
          : Group.fromJson(json['group'] as Map<String, dynamic>),
      corporate: json['corporate'] == null
          ? null
          : CorporatePrayer.fromJson(json['corporate'] as Map<String, dynamic>),
      anon: json['anon'] as bool?,
      groupId: json['group_id'] as String?,
      corporateId: json['corporate_id'] as String?,
      value: json['value'] as String,
      media: json['media'] as String?,
      praysCount: json['prays_count'] as int? ?? 0,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      hasPrayed: json['has_prayed'] == null
          ? null
          : DateTime.parse(json['has_prayed'] as String),
      pray: json['pray'] == null
          ? null
          : PUser.fromJson(json['pray'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PrayerImplToJson(_$PrayerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'user': instance.user?.toJson(),
      'group': instance.group?.toJson(),
      'corporate': instance.corporate?.toJson(),
      'anon': instance.anon,
      'group_id': instance.groupId,
      'corporate_id': instance.corporateId,
      'value': instance.value,
      'media': instance.media,
      'prays_count': instance.praysCount,
      'created_at': instance.createdAt?.toIso8601String(),
      'has_prayed': instance.hasPrayed?.toIso8601String(),
      'pray': instance.pray?.toJson(),
    };
