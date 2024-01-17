// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupRuleImpl _$$GroupRuleImplFromJson(Map<String, dynamic> json) =>
    _$GroupRuleImpl(
      id: json['id'] as int?,
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$GroupRuleImplToJson(_$GroupRuleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'created_at': instance.createdAt?.toIso8601String(),
    };
