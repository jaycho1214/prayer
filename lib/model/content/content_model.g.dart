// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentImpl _$$ContentImplFromJson(Map<String, dynamic> json) =>
    _$ContentImpl(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      processed: json['processed'] as bool? ?? false,
      alt: json['alt'] as String?,
      path: json['path'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ContentImplToJson(_$ContentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'processed': instance.processed,
      'alt': instance.alt,
      'path': instance.path,
      'created_at': instance.createdAt?.toIso8601String(),
    };
