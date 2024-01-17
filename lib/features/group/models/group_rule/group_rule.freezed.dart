// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GroupRule _$GroupRuleFromJson(Map<String, dynamic> json) {
  return _GroupRule.fromJson(json);
}

/// @nodoc
mixin _$GroupRule {
  int? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupRuleCopyWith<GroupRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupRuleCopyWith<$Res> {
  factory $GroupRuleCopyWith(GroupRule value, $Res Function(GroupRule) then) =
      _$GroupRuleCopyWithImpl<$Res, GroupRule>;
  @useResult
  $Res call(
      {int? id,
      String title,
      String description,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class _$GroupRuleCopyWithImpl<$Res, $Val extends GroupRule>
    implements $GroupRuleCopyWith<$Res> {
  _$GroupRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupRuleImplCopyWith<$Res>
    implements $GroupRuleCopyWith<$Res> {
  factory _$$GroupRuleImplCopyWith(
          _$GroupRuleImpl value, $Res Function(_$GroupRuleImpl) then) =
      __$$GroupRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String title,
      String description,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class __$$GroupRuleImplCopyWithImpl<$Res>
    extends _$GroupRuleCopyWithImpl<$Res, _$GroupRuleImpl>
    implements _$$GroupRuleImplCopyWith<$Res> {
  __$$GroupRuleImplCopyWithImpl(
      _$GroupRuleImpl _value, $Res Function(_$GroupRuleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$GroupRuleImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupRuleImpl extends _GroupRule {
  const _$GroupRuleImpl(
      {this.id,
      required this.title,
      required this.description,
      @JsonKey(name: 'created_at') this.createdAt})
      : super._();

  factory _$GroupRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupRuleImplFromJson(json);

  @override
  final int? id;
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'GroupRule(id: $id, title: $title, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupRuleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, description, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupRuleImplCopyWith<_$GroupRuleImpl> get copyWith =>
      __$$GroupRuleImplCopyWithImpl<_$GroupRuleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupRuleImplToJson(
      this,
    );
  }
}

abstract class _GroupRule extends GroupRule {
  const factory _GroupRule(
          {final int? id,
          required final String title,
          required final String description,
          @JsonKey(name: 'created_at') final DateTime? createdAt}) =
      _$GroupRuleImpl;
  const _GroupRule._() : super._();

  factory _GroupRule.fromJson(Map<String, dynamic> json) =
      _$GroupRuleImpl.fromJson;

  @override
  int? get id;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$GroupRuleImplCopyWith<_$GroupRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
