// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomNotificationImpl _$$CustomNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomNotificationImpl(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      targetUserId: json['target_user_id'] as String?,
      message: json['message'] as String,
      targetUser: json['target_user'] == null
          ? null
          : PUser.fromJson(json['target_user'] as Map<String, dynamic>),
      corporateId: json['corporate_id'] as String?,
      prayerId: json['prayer_id'] as String?,
      groupId: json['group_id'] as String?,
      group: json['group'] == null
          ? null
          : Group.fromJson(json['group'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$CustomNotificationImplToJson(
        _$CustomNotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'target_user_id': instance.targetUserId,
      'message': instance.message,
      'target_user': instance.targetUser,
      'corporate_id': instance.corporateId,
      'prayer_id': instance.prayerId,
      'group_id': instance.groupId,
      'group': instance.group,
      'created_at': instance.createdAt?.toIso8601String(),
    };