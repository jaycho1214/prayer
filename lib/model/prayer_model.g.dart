// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PrayerImpl _$$PrayerImplFromJson(Map<String, dynamic> json) => _$PrayerImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String?,
      groupId: json['group_id'] as String?,
      anon: json['anon'] as bool?,
      value: json['value'] as String,
      media: json['media'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      corporateId: json['corporate_id'] as String?,
      praysCount: json['prays_count'] as int? ?? 0,
      hasPrayed: json['has_prayed'] == null
          ? null
          : DateTime.parse(json['has_prayed'] as String),
      user: json['user'] == null
          ? null
          : PUser.fromJson(json['user'] as Map<String, dynamic>),
      pray: json['pray'] == null
          ? null
          : PUser.fromJson(json['pray'] as Map<String, dynamic>),
      group: json['group'] == null
          ? null
          : Group.fromJson(json['group'] as Map<String, dynamic>),
      corporate: json['corporate'] == null
          ? null
          : CorporatePrayer.fromJson(json['corporate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PrayerImplToJson(_$PrayerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'group_id': instance.groupId,
      'anon': instance.anon,
      'value': instance.value,
      'media': instance.media,
      'created_at': instance.createdAt?.toIso8601String(),
      'corporate_id': instance.corporateId,
      'prays_count': instance.praysCount,
      'has_prayed': instance.hasPrayed?.toIso8601String(),
      'user': instance.user?.toJson(),
      'pray': instance.pray?.toJson(),
      'group': instance.group?.toJson(),
      'corporate': instance.corporate?.toJson(),
    };
