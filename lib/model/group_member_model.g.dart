// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupMemberImpl _$$GroupMemberImplFromJson(Map<String, dynamic> json) =>
    _$GroupMemberImpl(
      uid: json['uid'] as String,
      name: json['name'] as String,
      username: json['username'] as String,
      profile: json['profile'] as String?,
      moderator: json['moderator'] == null
          ? null
          : DateTime.parse(json['moderator'] as String),
    );

Map<String, dynamic> _$$GroupMemberImplToJson(_$GroupMemberImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'username': instance.username,
      'profile': instance.profile,
      'moderator': instance.moderator?.toIso8601String(),
    };
