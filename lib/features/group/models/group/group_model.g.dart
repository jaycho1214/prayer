// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupImpl _$$GroupImplFromJson(Map<String, dynamic> json) => _$GroupImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      admin: json['admin'] == null
          ? null
          : PUser.fromJson(json['admin'] as Map<String, dynamic>),
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
      invitedAt: json['invited_at'] == null
          ? null
          : DateTime.parse(json['invited_at'] as String),
      bannedAt: json['banned_at'] == null
          ? null
          : DateTime.parse(json['banned_at'] as String),
      userBannedAt: json['user_banned_at'] == null
          ? null
          : DateTime.parse(json['user_banned_at'] as String),
      moderator: json['moderator'] == null
          ? null
          : DateTime.parse(json['moderator'] as String),
      rules: (json['rules'] as List<dynamic>?)
          ?.map((e) => GroupRule.fromJson(e as Map<String, dynamic>))
          .toList(),
      welcomeTitle: json['welcome_title'] as String?,
      welcomeMessage: json['welcome_message'] as String?,
      reminder: json['reminder'] == null
          ? null
          : Reminder.fromJson(json['reminder'] as Map<String, dynamic>),
      membersCount: json['members_count'] as int? ?? 0,
      prayersCount: json['prayers_count'] as int? ?? 0,
    );

Map<String, dynamic> _$$GroupImplToJson(_$GroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'admin': instance.admin,
      'description': instance.description,
      'banner': instance.banner,
      'admin_id': instance.adminId,
      'membership_type': instance.membershipType,
      'created_at': instance.createdAt?.toIso8601String(),
      'joined_at': instance.joinedAt?.toIso8601String(),
      'accepted_at': instance.acceptedAt?.toIso8601String(),
      'invited_at': instance.invitedAt?.toIso8601String(),
      'banned_at': instance.bannedAt?.toIso8601String(),
      'user_banned_at': instance.userBannedAt?.toIso8601String(),
      'moderator': instance.moderator?.toIso8601String(),
      'rules': instance.rules,
      'welcome_title': instance.welcomeTitle,
      'welcome_message': instance.welcomeMessage,
      'reminder': instance.reminder,
      'members_count': instance.membersCount,
      'prayers_count': instance.prayersCount,
    };
