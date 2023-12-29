// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CustomNotification _$CustomNotificationFromJson(Map<String, dynamic> json) {
  return _CustomNotification.fromJson(json);
}

/// @nodoc
mixin _$CustomNotification {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_user_id')
  String? get targetUserId => throw _privateConstructorUsedError;
  NotificationType get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_user')
  PUser? get targetUser => throw _privateConstructorUsedError;
  @JsonKey(name: 'corporate_id')
  String? get corporateId => throw _privateConstructorUsedError;
  @JsonKey(name: 'pray_id')
  int? get prayId => throw _privateConstructorUsedError;
  @JsonKey(name: 'prayer_id')
  String? get prayerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_id')
  String? get groupId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomNotificationCopyWith<CustomNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomNotificationCopyWith<$Res> {
  factory $CustomNotificationCopyWith(
          CustomNotification value, $Res Function(CustomNotification) then) =
      _$CustomNotificationCopyWithImpl<$Res, CustomNotification>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'target_user_id') String? targetUserId,
      NotificationType type,
      @JsonKey(name: 'target_user') PUser? targetUser,
      @JsonKey(name: 'corporate_id') String? corporateId,
      @JsonKey(name: 'pray_id') int? prayId,
      @JsonKey(name: 'prayer_id') String? prayerId,
      @JsonKey(name: 'group_id') String? groupId,
      @JsonKey(name: 'created_at') DateTime? createdAt});

  $PUserCopyWith<$Res>? get targetUser;
}

/// @nodoc
class _$CustomNotificationCopyWithImpl<$Res, $Val extends CustomNotification>
    implements $CustomNotificationCopyWith<$Res> {
  _$CustomNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? targetUserId = freezed,
    Object? type = null,
    Object? targetUser = freezed,
    Object? corporateId = freezed,
    Object? prayId = freezed,
    Object? prayerId = freezed,
    Object? groupId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      targetUserId: freezed == targetUserId
          ? _value.targetUserId
          : targetUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      targetUser: freezed == targetUser
          ? _value.targetUser
          : targetUser // ignore: cast_nullable_to_non_nullable
              as PUser?,
      corporateId: freezed == corporateId
          ? _value.corporateId
          : corporateId // ignore: cast_nullable_to_non_nullable
              as String?,
      prayId: freezed == prayId
          ? _value.prayId
          : prayId // ignore: cast_nullable_to_non_nullable
              as int?,
      prayerId: freezed == prayerId
          ? _value.prayerId
          : prayerId // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PUserCopyWith<$Res>? get targetUser {
    if (_value.targetUser == null) {
      return null;
    }

    return $PUserCopyWith<$Res>(_value.targetUser!, (value) {
      return _then(_value.copyWith(targetUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CustomNotificationImplCopyWith<$Res>
    implements $CustomNotificationCopyWith<$Res> {
  factory _$$CustomNotificationImplCopyWith(_$CustomNotificationImpl value,
          $Res Function(_$CustomNotificationImpl) then) =
      __$$CustomNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'target_user_id') String? targetUserId,
      NotificationType type,
      @JsonKey(name: 'target_user') PUser? targetUser,
      @JsonKey(name: 'corporate_id') String? corporateId,
      @JsonKey(name: 'pray_id') int? prayId,
      @JsonKey(name: 'prayer_id') String? prayerId,
      @JsonKey(name: 'group_id') String? groupId,
      @JsonKey(name: 'created_at') DateTime? createdAt});

  @override
  $PUserCopyWith<$Res>? get targetUser;
}

/// @nodoc
class __$$CustomNotificationImplCopyWithImpl<$Res>
    extends _$CustomNotificationCopyWithImpl<$Res, _$CustomNotificationImpl>
    implements _$$CustomNotificationImplCopyWith<$Res> {
  __$$CustomNotificationImplCopyWithImpl(_$CustomNotificationImpl _value,
      $Res Function(_$CustomNotificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? targetUserId = freezed,
    Object? type = null,
    Object? targetUser = freezed,
    Object? corporateId = freezed,
    Object? prayId = freezed,
    Object? prayerId = freezed,
    Object? groupId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$CustomNotificationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      targetUserId: freezed == targetUserId
          ? _value.targetUserId
          : targetUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      targetUser: freezed == targetUser
          ? _value.targetUser
          : targetUser // ignore: cast_nullable_to_non_nullable
              as PUser?,
      corporateId: freezed == corporateId
          ? _value.corporateId
          : corporateId // ignore: cast_nullable_to_non_nullable
              as String?,
      prayId: freezed == prayId
          ? _value.prayId
          : prayId // ignore: cast_nullable_to_non_nullable
              as int?,
      prayerId: freezed == prayerId
          ? _value.prayerId
          : prayerId // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomNotificationImpl implements _CustomNotification {
  const _$CustomNotificationImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'target_user_id') this.targetUserId,
      required this.type,
      @JsonKey(name: 'target_user') this.targetUser,
      @JsonKey(name: 'corporate_id') this.corporateId,
      @JsonKey(name: 'pray_id') this.prayId,
      @JsonKey(name: 'prayer_id') this.prayerId,
      @JsonKey(name: 'group_id') this.groupId,
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$CustomNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomNotificationImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'target_user_id')
  final String? targetUserId;
  @override
  final NotificationType type;
  @override
  @JsonKey(name: 'target_user')
  final PUser? targetUser;
  @override
  @JsonKey(name: 'corporate_id')
  final String? corporateId;
  @override
  @JsonKey(name: 'pray_id')
  final int? prayId;
  @override
  @JsonKey(name: 'prayer_id')
  final String? prayerId;
  @override
  @JsonKey(name: 'group_id')
  final String? groupId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'CustomNotification(id: $id, userId: $userId, targetUserId: $targetUserId, type: $type, targetUser: $targetUser, corporateId: $corporateId, prayId: $prayId, prayerId: $prayerId, groupId: $groupId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.targetUserId, targetUserId) ||
                other.targetUserId == targetUserId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.targetUser, targetUser) ||
                other.targetUser == targetUser) &&
            (identical(other.corporateId, corporateId) ||
                other.corporateId == corporateId) &&
            (identical(other.prayId, prayId) || other.prayId == prayId) &&
            (identical(other.prayerId, prayerId) ||
                other.prayerId == prayerId) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, targetUserId, type,
      targetUser, corporateId, prayId, prayerId, groupId, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomNotificationImplCopyWith<_$CustomNotificationImpl> get copyWith =>
      __$$CustomNotificationImplCopyWithImpl<_$CustomNotificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomNotificationImplToJson(
      this,
    );
  }
}

abstract class _CustomNotification implements CustomNotification {
  const factory _CustomNotification(
          {required final int id,
          @JsonKey(name: 'user_id') required final String userId,
          @JsonKey(name: 'target_user_id') final String? targetUserId,
          required final NotificationType type,
          @JsonKey(name: 'target_user') final PUser? targetUser,
          @JsonKey(name: 'corporate_id') final String? corporateId,
          @JsonKey(name: 'pray_id') final int? prayId,
          @JsonKey(name: 'prayer_id') final String? prayerId,
          @JsonKey(name: 'group_id') final String? groupId,
          @JsonKey(name: 'created_at') final DateTime? createdAt}) =
      _$CustomNotificationImpl;

  factory _CustomNotification.fromJson(Map<String, dynamic> json) =
      _$CustomNotificationImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'target_user_id')
  String? get targetUserId;
  @override
  NotificationType get type;
  @override
  @JsonKey(name: 'target_user')
  PUser? get targetUser;
  @override
  @JsonKey(name: 'corporate_id')
  String? get corporateId;
  @override
  @JsonKey(name: 'pray_id')
  int? get prayId;
  @override
  @JsonKey(name: 'prayer_id')
  String? get prayerId;
  @override
  @JsonKey(name: 'group_id')
  String? get groupId;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$CustomNotificationImplCopyWith<_$CustomNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
