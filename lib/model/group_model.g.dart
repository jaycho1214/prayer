// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupImpl _$$GroupImplFromJson(Map<String, dynamic> json) => _$GroupImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      user: json['user'] == null
          ? null
          : PUser.fromJson(json['user'] as Map<String, dynamic>),
      description: json['description'] as String?,
      banner: json['banner'] as String?,
      adminId: json['admin_id'] as String,
      membershipType: json['membership_type'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      joinedAt: json['joined_at'] == null
          ? null
          : DateTime.parse(json['joined_at'] as String),
      acceptedAt: json['accepted_at'] == null
          ? null
          : DateTime.parse(json['accepted_at'] as String),
      moderator: json['moderator'] == null
          ? null
          : DateTime.parse(json['moderator'] as String),
      membersCount: json['members_count'] as int? ?? 0,
      prayersCount: json['prayers_count'] as int? ?? 0,
    );

Map<String, dynamic> _$$GroupImplToJson(_$GroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'user': instance.user,
      'description': instance.description,
      'banner': instance.banner,
      'admin_id': instance.adminId,
      'membership_type': instance.membershipType,
      'created_at': instance.createdAt?.toIso8601String(),
      'joined_at': instance.joinedAt?.toIso8601String(),
      'accepted_at': instance.acceptedAt?.toIso8601String(),
      'moderator': instance.moderator?.toIso8601String(),
      'members_count': instance.membersCount,
      'prayers_count': instance.prayersCount,
    };
