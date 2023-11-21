// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PUser _$PUserFromJson(Map<String, dynamic> json) {
  return _PUser.fromJson(json);
}

/// @nodoc
mixin _$PUser {
  String get uid => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get profile => throw _privateConstructorUsedError;
  String? get banner => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'followed_at')
  DateTime? get followedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'followings_count')
  int get followingsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'followers_count')
  int get followersCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'prayers_count')
  int get prayersCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'prays_count')
  int get praysCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PUserCopyWith<PUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PUserCopyWith<$Res> {
  factory $PUserCopyWith(PUser value, $Res Function(PUser) then) =
      _$PUserCopyWithImpl<$Res, PUser>;
  @useResult
  $Res call(
      {String uid,
      String? email,
      String username,
      String name,
      String? bio,
      String? profile,
      String? banner,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'followed_at') DateTime? followedAt,
      @JsonKey(name: 'followings_count') int followingsCount,
      @JsonKey(name: 'followers_count') int followersCount,
      @JsonKey(name: 'prayers_count') int prayersCount,
      @JsonKey(name: 'prays_count') int praysCount});
}

/// @nodoc
class _$PUserCopyWithImpl<$Res, $Val extends PUser>
    implements $PUserCopyWith<$Res> {
  _$PUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = freezed,
    Object? username = null,
    Object? name = null,
    Object? bio = freezed,
    Object? profile = freezed,
    Object? banner = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? followedAt = freezed,
    Object? followingsCount = null,
    Object? followersCount = null,
    Object? prayersCount = null,
    Object? praysCount = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as String?,
      banner: freezed == banner
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      followedAt: freezed == followedAt
          ? _value.followedAt
          : followedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      followingsCount: null == followingsCount
          ? _value.followingsCount
          : followingsCount // ignore: cast_nullable_to_non_nullable
              as int,
      followersCount: null == followersCount
          ? _value.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as int,
      prayersCount: null == prayersCount
          ? _value.prayersCount
          : prayersCount // ignore: cast_nullable_to_non_nullable
              as int,
      praysCount: null == praysCount
          ? _value.praysCount
          : praysCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PUserImplCopyWith<$Res> implements $PUserCopyWith<$Res> {
  factory _$$PUserImplCopyWith(
          _$PUserImpl value, $Res Function(_$PUserImpl) then) =
      __$$PUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String? email,
      String username,
      String name,
      String? bio,
      String? profile,
      String? banner,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      @JsonKey(name: 'followed_at') DateTime? followedAt,
      @JsonKey(name: 'followings_count') int followingsCount,
      @JsonKey(name: 'followers_count') int followersCount,
      @JsonKey(name: 'prayers_count') int prayersCount,
      @JsonKey(name: 'prays_count') int praysCount});
}

/// @nodoc
class __$$PUserImplCopyWithImpl<$Res>
    extends _$PUserCopyWithImpl<$Res, _$PUserImpl>
    implements _$$PUserImplCopyWith<$Res> {
  __$$PUserImplCopyWithImpl(
      _$PUserImpl _value, $Res Function(_$PUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = freezed,
    Object? username = null,
    Object? name = null,
    Object? bio = freezed,
    Object? profile = freezed,
    Object? banner = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? followedAt = freezed,
    Object? followingsCount = null,
    Object? followersCount = null,
    Object? prayersCount = null,
    Object? praysCount = null,
  }) {
    return _then(_$PUserImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as String?,
      banner: freezed == banner
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      followedAt: freezed == followedAt
          ? _value.followedAt
          : followedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      followingsCount: null == followingsCount
          ? _value.followingsCount
          : followingsCount // ignore: cast_nullable_to_non_nullable
              as int,
      followersCount: null == followersCount
          ? _value.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as int,
      prayersCount: null == prayersCount
          ? _value.prayersCount
          : prayersCount // ignore: cast_nullable_to_non_nullable
              as int,
      praysCount: null == praysCount
          ? _value.praysCount
          : praysCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PUserImpl extends _PUser {
  const _$PUserImpl(
      {required this.uid,
      this.email,
      required this.username,
      required this.name,
      this.bio,
      this.profile,
      this.banner,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      @JsonKey(name: 'followed_at') this.followedAt,
      @JsonKey(name: 'followings_count') this.followingsCount = 0,
      @JsonKey(name: 'followers_count') this.followersCount = 0,
      @JsonKey(name: 'prayers_count') this.prayersCount = 0,
      @JsonKey(name: 'prays_count') this.praysCount = 0})
      : super._();

  factory _$PUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$PUserImplFromJson(json);

  @override
  final String uid;
  @override
  final String? email;
  @override
  final String username;
  @override
  final String name;
  @override
  final String? bio;
  @override
  final String? profile;
  @override
  final String? banner;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'followed_at')
  final DateTime? followedAt;
  @override
  @JsonKey(name: 'followings_count')
  final int followingsCount;
  @override
  @JsonKey(name: 'followers_count')
  final int followersCount;
  @override
  @JsonKey(name: 'prayers_count')
  final int prayersCount;
  @override
  @JsonKey(name: 'prays_count')
  final int praysCount;

  @override
  String toString() {
    return 'PUser(uid: $uid, email: $email, username: $username, name: $name, bio: $bio, profile: $profile, banner: $banner, createdAt: $createdAt, updatedAt: $updatedAt, followedAt: $followedAt, followingsCount: $followingsCount, followersCount: $followersCount, prayersCount: $prayersCount, praysCount: $praysCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PUserImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.banner, banner) || other.banner == banner) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.followedAt, followedAt) ||
                other.followedAt == followedAt) &&
            (identical(other.followingsCount, followingsCount) ||
                other.followingsCount == followingsCount) &&
            (identical(other.followersCount, followersCount) ||
                other.followersCount == followersCount) &&
            (identical(other.prayersCount, prayersCount) ||
                other.prayersCount == prayersCount) &&
            (identical(other.praysCount, praysCount) ||
                other.praysCount == praysCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      email,
      username,
      name,
      bio,
      profile,
      banner,
      createdAt,
      updatedAt,
      followedAt,
      followingsCount,
      followersCount,
      prayersCount,
      praysCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PUserImplCopyWith<_$PUserImpl> get copyWith =>
      __$$PUserImplCopyWithImpl<_$PUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PUserImplToJson(
      this,
    );
  }
}

abstract class _PUser extends PUser {
  const factory _PUser(
      {required final String uid,
      final String? email,
      required final String username,
      required final String name,
      final String? bio,
      final String? profile,
      final String? banner,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      @JsonKey(name: 'followed_at') final DateTime? followedAt,
      @JsonKey(name: 'followings_count') final int followingsCount,
      @JsonKey(name: 'followers_count') final int followersCount,
      @JsonKey(name: 'prayers_count') final int prayersCount,
      @JsonKey(name: 'prays_count') final int praysCount}) = _$PUserImpl;
  const _PUser._() : super._();

  factory _PUser.fromJson(Map<String, dynamic> json) = _$PUserImpl.fromJson;

  @override
  String get uid;
  @override
  String? get email;
  @override
  String get username;
  @override
  String get name;
  @override
  String? get bio;
  @override
  String? get profile;
  @override
  String? get banner;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'followed_at')
  DateTime? get followedAt;
  @override
  @JsonKey(name: 'followings_count')
  int get followingsCount;
  @override
  @JsonKey(name: 'followers_count')
  int get followersCount;
  @override
  @JsonKey(name: 'prayers_count')
  int get prayersCount;
  @override
  @JsonKey(name: 'prays_count')
  int get praysCount;
  @override
  @JsonKey(ignore: true)
  _$$PUserImplCopyWith<_$PUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
