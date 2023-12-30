// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_prayer_notification_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CorporatePrayerNotificationSettings
    _$CorporatePrayerNotificationSettingsFromJson(Map<String, dynamic> json) {
  return _CorporatePrayerNotificationSettings.fromJson(json);
}

/// @nodoc
mixin _$CorporatePrayerNotificationSettings {
  @JsonKey(name: 'on_reminder')
  bool get onReminder => throw _privateConstructorUsedError;
  @JsonKey(name: 'on_post')
  bool get onPost => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporatePrayerNotificationSettingsCopyWith<
          CorporatePrayerNotificationSettings>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporatePrayerNotificationSettingsCopyWith<$Res> {
  factory $CorporatePrayerNotificationSettingsCopyWith(
          CorporatePrayerNotificationSettings value,
          $Res Function(CorporatePrayerNotificationSettings) then) =
      _$CorporatePrayerNotificationSettingsCopyWithImpl<$Res,
          CorporatePrayerNotificationSettings>;
  @useResult
  $Res call(
      {@JsonKey(name: 'on_reminder') bool onReminder,
      @JsonKey(name: 'on_post') bool onPost});
}

/// @nodoc
class _$CorporatePrayerNotificationSettingsCopyWithImpl<$Res,
        $Val extends CorporatePrayerNotificationSettings>
    implements $CorporatePrayerNotificationSettingsCopyWith<$Res> {
  _$CorporatePrayerNotificationSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onReminder = null,
    Object? onPost = null,
  }) {
    return _then(_value.copyWith(
      onReminder: null == onReminder
          ? _value.onReminder
          : onReminder // ignore: cast_nullable_to_non_nullable
              as bool,
      onPost: null == onPost
          ? _value.onPost
          : onPost // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CorporatePrayerNotificationSettingsImplCopyWith<$Res>
    implements $CorporatePrayerNotificationSettingsCopyWith<$Res> {
  factory _$$CorporatePrayerNotificationSettingsImplCopyWith(
          _$CorporatePrayerNotificationSettingsImpl value,
          $Res Function(_$CorporatePrayerNotificationSettingsImpl) then) =
      __$$CorporatePrayerNotificationSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'on_reminder') bool onReminder,
      @JsonKey(name: 'on_post') bool onPost});
}

/// @nodoc
class __$$CorporatePrayerNotificationSettingsImplCopyWithImpl<$Res>
    extends _$CorporatePrayerNotificationSettingsCopyWithImpl<$Res,
        _$CorporatePrayerNotificationSettingsImpl>
    implements _$$CorporatePrayerNotificationSettingsImplCopyWith<$Res> {
  __$$CorporatePrayerNotificationSettingsImplCopyWithImpl(
      _$CorporatePrayerNotificationSettingsImpl _value,
      $Res Function(_$CorporatePrayerNotificationSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onReminder = null,
    Object? onPost = null,
  }) {
    return _then(_$CorporatePrayerNotificationSettingsImpl(
      onReminder: null == onReminder
          ? _value.onReminder
          : onReminder // ignore: cast_nullable_to_non_nullable
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
class _$CorporatePrayerNotificationSettingsImpl
    implements _CorporatePrayerNotificationSettings {
  const _$CorporatePrayerNotificationSettingsImpl(
      {@JsonKey(name: 'on_reminder') required this.onReminder,
      @JsonKey(name: 'on_post') required this.onPost});

  factory _$CorporatePrayerNotificationSettingsImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporatePrayerNotificationSettingsImplFromJson(json);

  @override
  @JsonKey(name: 'on_reminder')
  final bool onReminder;
  @override
  @JsonKey(name: 'on_post')
  final bool onPost;

  @override
  String toString() {
    return 'CorporatePrayerNotificationSettings(onReminder: $onReminder, onPost: $onPost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CorporatePrayerNotificationSettingsImpl &&
            (identical(other.onReminder, onReminder) ||
                other.onReminder == onReminder) &&
            (identical(other.onPost, onPost) || other.onPost == onPost));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, onReminder, onPost);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporatePrayerNotificationSettingsImplCopyWith<
          _$CorporatePrayerNotificationSettingsImpl>
      get copyWith => __$$CorporatePrayerNotificationSettingsImplCopyWithImpl<
          _$CorporatePrayerNotificationSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporatePrayerNotificationSettingsImplToJson(
      this,
    );
  }
}

abstract class _CorporatePrayerNotificationSettings
    implements CorporatePrayerNotificationSettings {
  const factory _CorporatePrayerNotificationSettings(
          {@JsonKey(name: 'on_reminder') required final bool onReminder,
          @JsonKey(name: 'on_post') required final bool onPost}) =
      _$CorporatePrayerNotificationSettingsImpl;

  factory _CorporatePrayerNotificationSettings.fromJson(
          Map<String, dynamic> json) =
      _$CorporatePrayerNotificationSettingsImpl.fromJson;

  @override
  @JsonKey(name: 'on_reminder')
  bool get onReminder;
  @override
  @JsonKey(name: 'on_post')
  bool get onPost;
  @override
  @JsonKey(ignore: true)
  _$$CorporatePrayerNotificationSettingsImplCopyWith<
          _$CorporatePrayerNotificationSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
