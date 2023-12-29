// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_pray_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PrayerPray _$PrayerPrayFromJson(Map<String, dynamic> json) {
  return _PrayerPray.fromJson(json);
}

/// @nodoc
mixin _$PrayerPray {
  PUser get user => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PrayerPrayCopyWith<PrayerPray> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrayerPrayCopyWith<$Res> {
  factory $PrayerPrayCopyWith(
          PrayerPray value, $Res Function(PrayerPray) then) =
      _$PrayerPrayCopyWithImpl<$Res, PrayerPray>;
  @useResult
  $Res call(
      {PUser user,
      int id,
      String? value,
      @JsonKey(name: 'created_at') DateTime createdAt});

  $PUserCopyWith<$Res> get user;
}

/// @nodoc
class _$PrayerPrayCopyWithImpl<$Res, $Val extends PrayerPray>
    implements $PrayerPrayCopyWith<$Res> {
  _$PrayerPrayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? id = null,
    Object? value = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as PUser,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PUserCopyWith<$Res> get user {
    return $PUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PrayerPrayImplCopyWith<$Res>
    implements $PrayerPrayCopyWith<$Res> {
  factory _$$PrayerPrayImplCopyWith(
          _$PrayerPrayImpl value, $Res Function(_$PrayerPrayImpl) then) =
      __$$PrayerPrayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PUser user,
      int id,
      String? value,
      @JsonKey(name: 'created_at') DateTime createdAt});

  @override
  $PUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$PrayerPrayImplCopyWithImpl<$Res>
    extends _$PrayerPrayCopyWithImpl<$Res, _$PrayerPrayImpl>
    implements _$$PrayerPrayImplCopyWith<$Res> {
  __$$PrayerPrayImplCopyWithImpl(
      _$PrayerPrayImpl _value, $Res Function(_$PrayerPrayImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? id = null,
    Object? value = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$PrayerPrayImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as PUser,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrayerPrayImpl implements _PrayerPray {
  const _$PrayerPrayImpl(
      {required this.user,
      required this.id,
      this.value,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$PrayerPrayImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrayerPrayImplFromJson(json);

  @override
  final PUser user;
  @override
  final int id;
  @override
  final String? value;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'PrayerPray(user: $user, id: $id, value: $value, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrayerPrayImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user, id, value, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrayerPrayImplCopyWith<_$PrayerPrayImpl> get copyWith =>
      __$$PrayerPrayImplCopyWithImpl<_$PrayerPrayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrayerPrayImplToJson(
      this,
    );
  }
}

abstract class _PrayerPray implements PrayerPray {
  const factory _PrayerPray(
          {required final PUser user,
          required final int id,
          final String? value,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$PrayerPrayImpl;

  factory _PrayerPray.fromJson(Map<String, dynamic> json) =
      _$PrayerPrayImpl.fromJson;

  @override
  PUser get user;
  @override
  int get id;
  @override
  String? get value;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$PrayerPrayImplCopyWith<_$PrayerPrayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
