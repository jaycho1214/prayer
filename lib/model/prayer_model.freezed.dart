// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Prayer _$PrayerFromJson(Map<String, dynamic> json) {
  return _Prayer.fromJson(json);
}

/// @nodoc
mixin _$Prayer {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  PUser? get user => throw _privateConstructorUsedError;
  Group? get group => throw _privateConstructorUsedError;
  CorporatePrayer? get corporate => throw _privateConstructorUsedError;
  bool? get anon => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_id')
  String? get groupId => throw _privateConstructorUsedError;
  @JsonKey(name: 'corporate_id')
  String? get corporateId => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  String? get media => throw _privateConstructorUsedError;
  @JsonKey(name: 'prays_count')
  int get praysCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_prayed')
  DateTime? get hasPrayed => throw _privateConstructorUsedError;
  PUser? get pray => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PrayerCopyWith<Prayer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrayerCopyWith<$Res> {
  factory $PrayerCopyWith(Prayer value, $Res Function(Prayer) then) =
      _$PrayerCopyWithImpl<$Res, Prayer>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String? userId,
      PUser? user,
      Group? group,
      CorporatePrayer? corporate,
      bool? anon,
      @JsonKey(name: 'group_id') String? groupId,
      @JsonKey(name: 'corporate_id') String? corporateId,
      String value,
      String? media,
      @JsonKey(name: 'prays_count') int praysCount,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'has_prayed') DateTime? hasPrayed,
      PUser? pray});

  $PUserCopyWith<$Res>? get user;
  $GroupCopyWith<$Res>? get group;
  $CorporatePrayerCopyWith<$Res>? get corporate;
  $PUserCopyWith<$Res>? get pray;
}

/// @nodoc
class _$PrayerCopyWithImpl<$Res, $Val extends Prayer>
    implements $PrayerCopyWith<$Res> {
  _$PrayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? user = freezed,
    Object? group = freezed,
    Object? corporate = freezed,
    Object? anon = freezed,
    Object? groupId = freezed,
    Object? corporateId = freezed,
    Object? value = null,
    Object? media = freezed,
    Object? praysCount = null,
    Object? createdAt = freezed,
    Object? hasPrayed = freezed,
    Object? pray = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as PUser?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group?,
      corporate: freezed == corporate
          ? _value.corporate
          : corporate // ignore: cast_nullable_to_non_nullable
              as CorporatePrayer?,
      anon: freezed == anon
          ? _value.anon
          : anon // ignore: cast_nullable_to_non_nullable
              as bool?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateId: freezed == corporateId
          ? _value.corporateId
          : corporateId // ignore: cast_nullable_to_non_nullable
              as String?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      media: freezed == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as String?,
      praysCount: null == praysCount
          ? _value.praysCount
          : praysCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hasPrayed: freezed == hasPrayed
          ? _value.hasPrayed
          : hasPrayed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pray: freezed == pray
          ? _value.pray
          : pray // ignore: cast_nullable_to_non_nullable
              as PUser?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $PUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GroupCopyWith<$Res>? get group {
    if (_value.group == null) {
      return null;
    }

    return $GroupCopyWith<$Res>(_value.group!, (value) {
      return _then(_value.copyWith(group: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CorporatePrayerCopyWith<$Res>? get corporate {
    if (_value.corporate == null) {
      return null;
    }

    return $CorporatePrayerCopyWith<$Res>(_value.corporate!, (value) {
      return _then(_value.copyWith(corporate: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PUserCopyWith<$Res>? get pray {
    if (_value.pray == null) {
      return null;
    }

    return $PUserCopyWith<$Res>(_value.pray!, (value) {
      return _then(_value.copyWith(pray: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PrayerImplCopyWith<$Res> implements $PrayerCopyWith<$Res> {
  factory _$$PrayerImplCopyWith(
          _$PrayerImpl value, $Res Function(_$PrayerImpl) then) =
      __$$PrayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String? userId,
      PUser? user,
      Group? group,
      CorporatePrayer? corporate,
      bool? anon,
      @JsonKey(name: 'group_id') String? groupId,
      @JsonKey(name: 'corporate_id') String? corporateId,
      String value,
      String? media,
      @JsonKey(name: 'prays_count') int praysCount,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'has_prayed') DateTime? hasPrayed,
      PUser? pray});

  @override
  $PUserCopyWith<$Res>? get user;
  @override
  $GroupCopyWith<$Res>? get group;
  @override
  $CorporatePrayerCopyWith<$Res>? get corporate;
  @override
  $PUserCopyWith<$Res>? get pray;
}

/// @nodoc
class __$$PrayerImplCopyWithImpl<$Res>
    extends _$PrayerCopyWithImpl<$Res, _$PrayerImpl>
    implements _$$PrayerImplCopyWith<$Res> {
  __$$PrayerImplCopyWithImpl(
      _$PrayerImpl _value, $Res Function(_$PrayerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? user = freezed,
    Object? group = freezed,
    Object? corporate = freezed,
    Object? anon = freezed,
    Object? groupId = freezed,
    Object? corporateId = freezed,
    Object? value = null,
    Object? media = freezed,
    Object? praysCount = null,
    Object? createdAt = freezed,
    Object? hasPrayed = freezed,
    Object? pray = freezed,
  }) {
    return _then(_$PrayerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as PUser?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group?,
      corporate: freezed == corporate
          ? _value.corporate
          : corporate // ignore: cast_nullable_to_non_nullable
              as CorporatePrayer?,
      anon: freezed == anon
          ? _value.anon
          : anon // ignore: cast_nullable_to_non_nullable
              as bool?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateId: freezed == corporateId
          ? _value.corporateId
          : corporateId // ignore: cast_nullable_to_non_nullable
              as String?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      media: freezed == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as String?,
      praysCount: null == praysCount
          ? _value.praysCount
          : praysCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hasPrayed: freezed == hasPrayed
          ? _value.hasPrayed
          : hasPrayed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pray: freezed == pray
          ? _value.pray
          : pray // ignore: cast_nullable_to_non_nullable
              as PUser?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$PrayerImpl implements _Prayer {
  const _$PrayerImpl(
      {required this.id,
      @JsonKey(name: 'user_id') this.userId,
      this.user,
      this.group,
      this.corporate,
      this.anon,
      @JsonKey(name: 'group_id') this.groupId,
      @JsonKey(name: 'corporate_id') this.corporateId,
      required this.value,
      this.media,
      @JsonKey(name: 'prays_count') this.praysCount = 0,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'has_prayed') this.hasPrayed,
      this.pray});

  factory _$PrayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrayerImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  final PUser? user;
  @override
  final Group? group;
  @override
  final CorporatePrayer? corporate;
  @override
  final bool? anon;
  @override
  @JsonKey(name: 'group_id')
  final String? groupId;
  @override
  @JsonKey(name: 'corporate_id')
  final String? corporateId;
  @override
  final String value;
  @override
  final String? media;
  @override
  @JsonKey(name: 'prays_count')
  final int praysCount;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'has_prayed')
  final DateTime? hasPrayed;
  @override
  final PUser? pray;

  @override
  String toString() {
    return 'Prayer(id: $id, userId: $userId, user: $user, group: $group, corporate: $corporate, anon: $anon, groupId: $groupId, corporateId: $corporateId, value: $value, media: $media, praysCount: $praysCount, createdAt: $createdAt, hasPrayed: $hasPrayed, pray: $pray)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.corporate, corporate) ||
                other.corporate == corporate) &&
            (identical(other.anon, anon) || other.anon == anon) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.corporateId, corporateId) ||
                other.corporateId == corporateId) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.media, media) || other.media == media) &&
            (identical(other.praysCount, praysCount) ||
                other.praysCount == praysCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.hasPrayed, hasPrayed) ||
                other.hasPrayed == hasPrayed) &&
            (identical(other.pray, pray) || other.pray == pray));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      user,
      group,
      corporate,
      anon,
      groupId,
      corporateId,
      value,
      media,
      praysCount,
      createdAt,
      hasPrayed,
      pray);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrayerImplCopyWith<_$PrayerImpl> get copyWith =>
      __$$PrayerImplCopyWithImpl<_$PrayerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrayerImplToJson(
      this,
    );
  }
}

abstract class _Prayer implements Prayer {
  const factory _Prayer(
      {required final String id,
      @JsonKey(name: 'user_id') final String? userId,
      final PUser? user,
      final Group? group,
      final CorporatePrayer? corporate,
      final bool? anon,
      @JsonKey(name: 'group_id') final String? groupId,
      @JsonKey(name: 'corporate_id') final String? corporateId,
      required final String value,
      final String? media,
      @JsonKey(name: 'prays_count') final int praysCount,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'has_prayed') final DateTime? hasPrayed,
      final PUser? pray}) = _$PrayerImpl;

  factory _Prayer.fromJson(Map<String, dynamic> json) = _$PrayerImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  PUser? get user;
  @override
  Group? get group;
  @override
  CorporatePrayer? get corporate;
  @override
  bool? get anon;
  @override
  @JsonKey(name: 'group_id')
  String? get groupId;
  @override
  @JsonKey(name: 'corporate_id')
  String? get corporateId;
  @override
  String get value;
  @override
  String? get media;
  @override
  @JsonKey(name: 'prays_count')
  int get praysCount;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'has_prayed')
  DateTime? get hasPrayed;
  @override
  PUser? get pray;
  @override
  @JsonKey(ignore: true)
  _$$PrayerImplCopyWith<_$PrayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
