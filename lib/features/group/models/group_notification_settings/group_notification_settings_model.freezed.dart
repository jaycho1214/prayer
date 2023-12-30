// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_notification_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GroupNotificationSettings _$GroupNotificationSettingsFromJson(
    Map<String, dynamic> json) {
  return _GroupNotificationSettings.fromJson(json);
}

/// @nodoc
mixin _$GroupNotificationSettings {
  @JsonKey(name: 'on_moderator_post')
  bool get onModeratorPost => throw _privateConstructorUsedError;
  @JsonKey(name: 'on_post')
  bool get onPost => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupNotificationSettingsCopyWith<GroupNotificationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupNotificationSettingsCopyWith<$Res> {
  factory $GroupNotificationSettingsCopyWith(GroupNotificationSettings value,
          $Res Function(GroupNotificationSettings) then) =
      _$GroupNotificationSettingsCopyWithImpl<$Res, GroupNotificationSettings>;
  @useResult
  $Res call(
      {@JsonKey(name: 'on_moderator_post') bool onModeratorPost,
      @JsonKey(name: 'on_post') bool onPost});
}

/// @nodoc
class _$GroupNotificationSettingsCopyWithImpl<$Res,
        $Val extends GroupNotificationSettings>
    implements $GroupNotificationSettingsCopyWith<$Res> {
  _$GroupNotificationSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onModeratorPost = null,
    Object? onPost = null,
  }) {
    return _then(_value.copyWith(
      onModeratorPost: null == onModeratorPost
          ? _value.onModeratorPost
          : onModeratorPost // ignore: cast_nullable_to_non_nullable
              as bool,
      onPost: null == onPost
          ? _value.onPost
          : onPost // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupNotificationSettingsImplCopyWith<$Res>
    implements $GroupNotificationSettingsCopyWith<$Res> {
  factory _$$GroupNotificationSettingsImplCopyWith(
          _$GroupNotificationSettingsImpl value,
          $Res Function(_$GroupNotificationSettingsImpl) then) =
      __$$GroupNotificationSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'on_moderator_post') bool onModeratorPost,
      @JsonKey(name: 'on_post') bool onPost});
}

/// @nodoc
class __$$GroupNotificationSettingsImplCopyWithImpl<$Res>
    extends _$GroupNotificationSettingsCopyWithImpl<$Res,
        _$GroupNotificationSettingsImpl>
    implements _$$GroupNotificationSettingsImplCopyWith<$Res> {
  __$$GroupNotificationSettingsImplCopyWithImpl(
      _$GroupNotificationSettingsImpl _value,
      $Res Function(_$GroupNotificationSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onModeratorPost = null,
    Object? onPost = null,
  }) {
    return _then(_$GroupNotificationSettingsImpl(
      onModeratorPost: null == onModeratorPost
          ? _value.onModeratorPost
          : onModeratorPost // ignore: cast_nullable_to_non_nullable
              as bool,
      onPost: null == onPost
          ? _value.onPost
          : onPost // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupNotificationSettingsImpl extends _GroupNotificationSettings {
  const _$GroupNotificationSettingsImpl(
      {@JsonKey(name: 'on_moderator_post') required this.onModeratorPost,
      @JsonKey(name: 'on_post') required this.onPost})
      : super._();

  factory _$GroupNotificationSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupNotificationSettingsImplFromJson(json);

  @override
  @JsonKey(name: 'on_moderator_post')
  final bool onModeratorPost;
  @override
  @JsonKey(name: 'on_post')
  final bool onPost;

  @override
  String toString() {
    return 'GroupNotificationSettings(onModeratorPost: $onModeratorPost, onPost: $onPost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupNotificationSettingsImpl &&
            (identical(other.onModeratorPost, onModeratorPost) ||
                other.onModeratorPost == onModeratorPost) &&
            (identical(other.onPost, onPost) || other.onPost == onPost));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, onModeratorPost, onPost);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupNotificationSettingsImplCopyWith<_$GroupNotificationSettingsImpl>
      get copyWith => __$$GroupNotificationSettingsImplCopyWithImpl<
          _$GroupNotificationSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupNotificationSettingsImplToJson(
      this,
    );
  }
}

abstract class _GroupNotificationSettings extends GroupNotificationSettings {
  const factory _GroupNotificationSettings(
      {@JsonKey(name: 'on_moderator_post') required final bool onModeratorPost,
      @JsonKey(name: 'on_post')
      required final bool onPost}) = _$GroupNotificationSettingsImpl;
  const _GroupNotificationSettings._() : super._();

  factory _GroupNotificationSettings.fromJson(Map<String, dynamic> json) =
      _$GroupNotificationSettingsImpl.fromJson;

  @override
  @JsonKey(name: 'on_moderator_post')
  bool get onModeratorPost;
  @override
  @JsonKey(name: 'on_post')
  bool get onPost;
  @override
  @JsonKey(ignore: true)
  _$$GroupNotificationSettingsImplCopyWith<_$GroupNotificationSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
