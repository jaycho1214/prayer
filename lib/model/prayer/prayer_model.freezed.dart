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
  @JsonKey(name: 'group_id')
  String? get groupId => throw _privateConstructorUsedError;
  bool? get anon => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  List<Content> get contents => throw _privateConstructorUsedError;
  List<int> get verses => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'corporate_id')
  String? get corporateId => throw _privateConstructorUsedError;
  @JsonKey(name: 'prays_count')
  int get praysCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_prayed')
  DateTime? get hasPrayed => throw _privateConstructorUsedError;
  PUser? get user => throw _privateConstructorUsedError;
  PUser? get pray => throw _privateConstructorUsedError;
  Group? get group => throw _privateConstructorUsedError;
  CorporatePrayer? get corporate => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'group_id') String? groupId,
      bool? anon,
      String value,
      List<Content> contents,
      List<int> verses,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'corporate_id') String? corporateId,
      @JsonKey(name: 'prays_count') int praysCount,
      @JsonKey(name: 'has_prayed') DateTime? hasPrayed,
      PUser? user,
      PUser? pray,
      Group? group,
      CorporatePrayer? corporate});

  $PUserCopyWith<$Res>? get user;
  $PUserCopyWith<$Res>? get pray;
  $GroupCopyWith<$Res>? get group;
  $CorporatePrayerCopyWith<$Res>? get corporate;
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
    Object? groupId = freezed,
    Object? anon = freezed,
    Object? value = null,
    Object? contents = null,
    Object? verses = null,
    Object? createdAt = freezed,
    Object? corporateId = freezed,
    Object? praysCount = null,
    Object? hasPrayed = freezed,
    Object? user = freezed,
    Object? pray = freezed,
    Object? group = freezed,
    Object? corporate = freezed,
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
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      anon: freezed == anon
          ? _value.anon
          : anon // ignore: cast_nullable_to_non_nullable
              as bool?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      contents: null == contents
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as List<Content>,
      verses: null == verses
          ? _value.verses
          : verses // ignore: cast_nullable_to_non_nullable
              as List<int>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      corporateId: freezed == corporateId
          ? _value.corporateId
          : corporateId // ignore: cast_nullable_to_non_nullable
              as String?,
      praysCount: null == praysCount
          ? _value.praysCount
          : praysCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasPrayed: freezed == hasPrayed
          ? _value.hasPrayed
          : hasPrayed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as PUser?,
      pray: freezed == pray
          ? _value.pray
          : pray // ignore: cast_nullable_to_non_nullable
              as PUser?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group?,
      corporate: freezed == corporate
          ? _value.corporate
          : corporate // ignore: cast_nullable_to_non_nullable
              as CorporatePrayer?,
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
  $PUserCopyWith<$Res>? get pray {
    if (_value.pray == null) {
      return null;
    }

    return $PUserCopyWith<$Res>(_value.pray!, (value) {
      return _then(_value.copyWith(pray: value) as $Val);
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
      @JsonKey(name: 'group_id') String? groupId,
      bool? anon,
      String value,
      List<Content> contents,
      List<int> verses,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'corporate_id') String? corporateId,
      @JsonKey(name: 'prays_count') int praysCount,
      @JsonKey(name: 'has_prayed') DateTime? hasPrayed,
      PUser? user,
      PUser? pray,
      Group? group,
      CorporatePrayer? corporate});

  @override
  $PUserCopyWith<$Res>? get user;
  @override
  $PUserCopyWith<$Res>? get pray;
  @override
  $GroupCopyWith<$Res>? get group;
  @override
  $CorporatePrayerCopyWith<$Res>? get corporate;
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
    Object? groupId = freezed,
    Object? anon = freezed,
    Object? value = null,
    Object? contents = null,
    Object? verses = null,
    Object? createdAt = freezed,
    Object? corporateId = freezed,
    Object? praysCount = null,
    Object? hasPrayed = freezed,
    Object? user = freezed,
    Object? pray = freezed,
    Object? group = freezed,
    Object? corporate = freezed,
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
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      anon: freezed == anon
          ? _value.anon
          : anon // ignore: cast_nullable_to_non_nullable
              as bool?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      contents: null == contents
          ? _value._contents
          : contents // ignore: cast_nullable_to_non_nullable
              as List<Content>,
      verses: null == verses
          ? _value._verses
          : verses // ignore: cast_nullable_to_non_nullable
              as List<int>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      corporateId: freezed == corporateId
          ? _value.corporateId
          : corporateId // ignore: cast_nullable_to_non_nullable
              as String?,
      praysCount: null == praysCount
          ? _value.praysCount
          : praysCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasPrayed: freezed == hasPrayed
          ? _value.hasPrayed
          : hasPrayed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as PUser?,
      pray: freezed == pray
          ? _value.pray
          : pray // ignore: cast_nullable_to_non_nullable
              as PUser?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group?,
      corporate: freezed == corporate
          ? _value.corporate
          : corporate // ignore: cast_nullable_to_non_nullable
              as CorporatePrayer?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$PrayerImpl implements _Prayer {
  const _$PrayerImpl(
      {required this.id,
      @JsonKey(name: 'user_id') this.userId,
      @JsonKey(name: 'group_id') this.groupId,
      this.anon,
      required this.value,
      final List<Content> contents = const [],
      final List<int> verses = const [],
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'corporate_id') this.corporateId,
      @JsonKey(name: 'prays_count') this.praysCount = 0,
      @JsonKey(name: 'has_prayed') this.hasPrayed,
      this.user,
      this.pray,
      this.group,
      this.corporate})
      : _contents = contents,
        _verses = verses;

  factory _$PrayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrayerImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @JsonKey(name: 'group_id')
  final String? groupId;
  @override
  final bool? anon;
  @override
  final String value;
  final List<Content> _contents;
  @override
  @JsonKey()
  List<Content> get contents {
    if (_contents is EqualUnmodifiableListView) return _contents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contents);
  }

  final List<int> _verses;
  @override
  @JsonKey()
  List<int> get verses {
    if (_verses is EqualUnmodifiableListView) return _verses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_verses);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'corporate_id')
  final String? corporateId;
  @override
  @JsonKey(name: 'prays_count')
  final int praysCount;
  @override
  @JsonKey(name: 'has_prayed')
  final DateTime? hasPrayed;
  @override
  final PUser? user;
  @override
  final PUser? pray;
  @override
  final Group? group;
  @override
  final CorporatePrayer? corporate;

  @override
  String toString() {
    return 'Prayer(id: $id, userId: $userId, groupId: $groupId, anon: $anon, value: $value, contents: $contents, verses: $verses, createdAt: $createdAt, corporateId: $corporateId, praysCount: $praysCount, hasPrayed: $hasPrayed, user: $user, pray: $pray, group: $group, corporate: $corporate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.anon, anon) || other.anon == anon) &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality().equals(other._contents, _contents) &&
            const DeepCollectionEquality().equals(other._verses, _verses) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.corporateId, corporateId) ||
                other.corporateId == corporateId) &&
            (identical(other.praysCount, praysCount) ||
                other.praysCount == praysCount) &&
            (identical(other.hasPrayed, hasPrayed) ||
                other.hasPrayed == hasPrayed) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.pray, pray) || other.pray == pray) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.corporate, corporate) ||
                other.corporate == corporate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      groupId,
      anon,
      value,
      const DeepCollectionEquality().hash(_contents),
      const DeepCollectionEquality().hash(_verses),
      createdAt,
      corporateId,
      praysCount,
      hasPrayed,
      user,
      pray,
      group,
      corporate);

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
      @JsonKey(name: 'group_id') final String? groupId,
      final bool? anon,
      required final String value,
      final List<Content> contents,
      final List<int> verses,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'corporate_id') final String? corporateId,
      @JsonKey(name: 'prays_count') final int praysCount,
      @JsonKey(name: 'has_prayed') final DateTime? hasPrayed,
      final PUser? user,
      final PUser? pray,
      final Group? group,
      final CorporatePrayer? corporate}) = _$PrayerImpl;

  factory _Prayer.fromJson(Map<String, dynamic> json) = _$PrayerImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  @JsonKey(name: 'group_id')
  String? get groupId;
  @override
  bool? get anon;
  @override
  String get value;
  @override
  List<Content> get contents;
  @override
  List<int> get verses;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'corporate_id')
  String? get corporateId;
  @override
  @JsonKey(name: 'prays_count')
  int get praysCount;
  @override
  @JsonKey(name: 'has_prayed')
  DateTime? get hasPrayed;
  @override
  PUser? get user;
  @override
  PUser? get pray;
  @override
  Group? get group;
  @override
  CorporatePrayer? get corporate;
  @override
  @JsonKey(ignore: true)
  _$$PrayerImplCopyWith<_$PrayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
