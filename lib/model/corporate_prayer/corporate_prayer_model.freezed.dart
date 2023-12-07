// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_prayer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CorporatePrayer _$CorporatePrayerFromJson(Map<String, dynamic> json) {
  return _CorporatePrayer.fromJson(json);
}

/// @nodoc
mixin _$CorporatePrayer {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  PUser? get user => throw _privateConstructorUsedError;
  Group? get group => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_id')
  String get groupId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  Reminder? get reminder => throw _privateConstructorUsedError;
  @CorporatePrayerConverter()
  List<String>? get prayers => throw _privateConstructorUsedError;
  @JsonKey(name: 'prayers_count')
  int get prayersCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'started_at')
  DateTime? get startedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'ended_at')
  DateTime? get endedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporatePrayerCopyWith<CorporatePrayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporatePrayerCopyWith<$Res> {
  factory $CorporatePrayerCopyWith(
          CorporatePrayer value, $Res Function(CorporatePrayer) then) =
      _$CorporatePrayerCopyWithImpl<$Res, CorporatePrayer>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      PUser? user,
      Group? group,
      @JsonKey(name: 'group_id') String groupId,
      String title,
      String? description,
      Reminder? reminder,
      @CorporatePrayerConverter() List<String>? prayers,
      @JsonKey(name: 'prayers_count') int prayersCount,
      @JsonKey(name: 'started_at') DateTime? startedAt,
      @JsonKey(name: 'ended_at') DateTime? endedAt,
      @JsonKey(name: 'created_at') DateTime? createdAt});

  $PUserCopyWith<$Res>? get user;
  $GroupCopyWith<$Res>? get group;
  $ReminderCopyWith<$Res>? get reminder;
}

/// @nodoc
class _$CorporatePrayerCopyWithImpl<$Res, $Val extends CorporatePrayer>
    implements $CorporatePrayerCopyWith<$Res> {
  _$CorporatePrayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? user = freezed,
    Object? group = freezed,
    Object? groupId = null,
    Object? title = null,
    Object? description = freezed,
    Object? reminder = freezed,
    Object? prayers = freezed,
    Object? prayersCount = null,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as PUser?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group?,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      reminder: freezed == reminder
          ? _value.reminder
          : reminder // ignore: cast_nullable_to_non_nullable
              as Reminder?,
      prayers: freezed == prayers
          ? _value.prayers
          : prayers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      prayersCount: null == prayersCount
          ? _value.prayersCount
          : prayersCount // ignore: cast_nullable_to_non_nullable
              as int,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endedAt: freezed == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
  $ReminderCopyWith<$Res>? get reminder {
    if (_value.reminder == null) {
      return null;
    }

    return $ReminderCopyWith<$Res>(_value.reminder!, (value) {
      return _then(_value.copyWith(reminder: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CorporatePrayerImplCopyWith<$Res>
    implements $CorporatePrayerCopyWith<$Res> {
  factory _$$CorporatePrayerImplCopyWith(_$CorporatePrayerImpl value,
          $Res Function(_$CorporatePrayerImpl) then) =
      __$$CorporatePrayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      PUser? user,
      Group? group,
      @JsonKey(name: 'group_id') String groupId,
      String title,
      String? description,
      Reminder? reminder,
      @CorporatePrayerConverter() List<String>? prayers,
      @JsonKey(name: 'prayers_count') int prayersCount,
      @JsonKey(name: 'started_at') DateTime? startedAt,
      @JsonKey(name: 'ended_at') DateTime? endedAt,
      @JsonKey(name: 'created_at') DateTime? createdAt});

  @override
  $PUserCopyWith<$Res>? get user;
  @override
  $GroupCopyWith<$Res>? get group;
  @override
  $ReminderCopyWith<$Res>? get reminder;
}

/// @nodoc
class __$$CorporatePrayerImplCopyWithImpl<$Res>
    extends _$CorporatePrayerCopyWithImpl<$Res, _$CorporatePrayerImpl>
    implements _$$CorporatePrayerImplCopyWith<$Res> {
  __$$CorporatePrayerImplCopyWithImpl(
      _$CorporatePrayerImpl _value, $Res Function(_$CorporatePrayerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? user = freezed,
    Object? group = freezed,
    Object? groupId = null,
    Object? title = null,
    Object? description = freezed,
    Object? reminder = freezed,
    Object? prayers = freezed,
    Object? prayersCount = null,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$CorporatePrayerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as PUser?,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group?,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      reminder: freezed == reminder
          ? _value.reminder
          : reminder // ignore: cast_nullable_to_non_nullable
              as Reminder?,
      prayers: freezed == prayers
          ? _value._prayers
          : prayers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      prayersCount: null == prayersCount
          ? _value.prayersCount
          : prayersCount // ignore: cast_nullable_to_non_nullable
              as int,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endedAt: freezed == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporatePrayerImpl implements _CorporatePrayer {
  const _$CorporatePrayerImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      this.user,
      this.group,
      @JsonKey(name: 'group_id') required this.groupId,
      required this.title,
      this.description,
      this.reminder,
      @CorporatePrayerConverter() final List<String>? prayers,
      @JsonKey(name: 'prayers_count') this.prayersCount = 0,
      @JsonKey(name: 'started_at') this.startedAt,
      @JsonKey(name: 'ended_at') this.endedAt,
      @JsonKey(name: 'created_at') this.createdAt})
      : _prayers = prayers;

  factory _$CorporatePrayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$CorporatePrayerImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final PUser? user;
  @override
  final Group? group;
  @override
  @JsonKey(name: 'group_id')
  final String groupId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final Reminder? reminder;
  final List<String>? _prayers;
  @override
  @CorporatePrayerConverter()
  List<String>? get prayers {
    final value = _prayers;
    if (value == null) return null;
    if (_prayers is EqualUnmodifiableListView) return _prayers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'prayers_count')
  final int prayersCount;
  @override
  @JsonKey(name: 'started_at')
  final DateTime? startedAt;
  @override
  @JsonKey(name: 'ended_at')
  final DateTime? endedAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'CorporatePrayer(id: $id, userId: $userId, user: $user, group: $group, groupId: $groupId, title: $title, description: $description, reminder: $reminder, prayers: $prayers, prayersCount: $prayersCount, startedAt: $startedAt, endedAt: $endedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CorporatePrayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.reminder, reminder) ||
                other.reminder == reminder) &&
            const DeepCollectionEquality().equals(other._prayers, _prayers) &&
            (identical(other.prayersCount, prayersCount) ||
                other.prayersCount == prayersCount) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      user,
      group,
      groupId,
      title,
      description,
      reminder,
      const DeepCollectionEquality().hash(_prayers),
      prayersCount,
      startedAt,
      endedAt,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporatePrayerImplCopyWith<_$CorporatePrayerImpl> get copyWith =>
      __$$CorporatePrayerImplCopyWithImpl<_$CorporatePrayerImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporatePrayerImplToJson(
      this,
    );
  }
}

abstract class _CorporatePrayer implements CorporatePrayer {
  const factory _CorporatePrayer(
          {required final String id,
          @JsonKey(name: 'user_id') required final String userId,
          final PUser? user,
          final Group? group,
          @JsonKey(name: 'group_id') required final String groupId,
          required final String title,
          final String? description,
          final Reminder? reminder,
          @CorporatePrayerConverter() final List<String>? prayers,
          @JsonKey(name: 'prayers_count') final int prayersCount,
          @JsonKey(name: 'started_at') final DateTime? startedAt,
          @JsonKey(name: 'ended_at') final DateTime? endedAt,
          @JsonKey(name: 'created_at') final DateTime? createdAt}) =
      _$CorporatePrayerImpl;

  factory _CorporatePrayer.fromJson(Map<String, dynamic> json) =
      _$CorporatePrayerImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  PUser? get user;
  @override
  Group? get group;
  @override
  @JsonKey(name: 'group_id')
  String get groupId;
  @override
  String get title;
  @override
  String? get description;
  @override
  Reminder? get reminder;
  @override
  @CorporatePrayerConverter()
  List<String>? get prayers;
  @override
  @JsonKey(name: 'prayers_count')
  int get prayersCount;
  @override
  @JsonKey(name: 'started_at')
  DateTime? get startedAt;
  @override
  @JsonKey(name: 'ended_at')
  DateTime? get endedAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$CorporatePrayerImplCopyWith<_$CorporatePrayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
