// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthenticationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationProvider provider) signIn,
    required TResult Function(String username, String name, String? bio,
            String? profile, String? banner)
        signUp,
    required TResult Function() signOut,
    required TResult Function() refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationProvider provider)? signIn,
    TResult? Function(String username, String name, String? bio,
            String? profile, String? banner)?
        signUp,
    TResult? Function()? signOut,
    TResult? Function()? refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationProvider provider)? signIn,
    TResult Function(String username, String name, String? bio, String? profile,
            String? banner)?
        signUp,
    TResult Function()? signOut,
    TResult Function()? refresh,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationEventSignIn value) signIn,
    required TResult Function(AuthenticationEventSignUp value) signUp,
    required TResult Function(AuthenticationEventSignOut value) signOut,
    required TResult Function(AuthenticationEventRefresh value) refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationEventSignIn value)? signIn,
    TResult? Function(AuthenticationEventSignUp value)? signUp,
    TResult? Function(AuthenticationEventSignOut value)? signOut,
    TResult? Function(AuthenticationEventRefresh value)? refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationEventSignIn value)? signIn,
    TResult Function(AuthenticationEventSignUp value)? signUp,
    TResult Function(AuthenticationEventSignOut value)? signOut,
    TResult Function(AuthenticationEventRefresh value)? refresh,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationEventCopyWith<$Res> {
  factory $AuthenticationEventCopyWith(
          AuthenticationEvent value, $Res Function(AuthenticationEvent) then) =
      _$AuthenticationEventCopyWithImpl<$Res, AuthenticationEvent>;
}

/// @nodoc
class _$AuthenticationEventCopyWithImpl<$Res, $Val extends AuthenticationEvent>
    implements $AuthenticationEventCopyWith<$Res> {
  _$AuthenticationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AuthenticationEventSignInImplCopyWith<$Res> {
  factory _$$AuthenticationEventSignInImplCopyWith(
          _$AuthenticationEventSignInImpl value,
          $Res Function(_$AuthenticationEventSignInImpl) then) =
      __$$AuthenticationEventSignInImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AuthenticationProvider provider});
}

/// @nodoc
class __$$AuthenticationEventSignInImplCopyWithImpl<$Res>
    extends _$AuthenticationEventCopyWithImpl<$Res,
        _$AuthenticationEventSignInImpl>
    implements _$$AuthenticationEventSignInImplCopyWith<$Res> {
  __$$AuthenticationEventSignInImplCopyWithImpl(
      _$AuthenticationEventSignInImpl _value,
      $Res Function(_$AuthenticationEventSignInImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
  }) {
    return _then(_$AuthenticationEventSignInImpl(
      null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as AuthenticationProvider,
    ));
  }
}

/// @nodoc

class _$AuthenticationEventSignInImpl implements AuthenticationEventSignIn {
  _$AuthenticationEventSignInImpl(this.provider);

  @override
  final AuthenticationProvider provider;

  @override
  String toString() {
    return 'AuthenticationEvent.signIn(provider: $provider)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationEventSignInImpl &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @override
  int get hashCode => Object.hash(runtimeType, provider);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationEventSignInImplCopyWith<_$AuthenticationEventSignInImpl>
      get copyWith => __$$AuthenticationEventSignInImplCopyWithImpl<
          _$AuthenticationEventSignInImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationProvider provider) signIn,
    required TResult Function(String username, String name, String? bio,
            String? profile, String? banner)
        signUp,
    required TResult Function() signOut,
    required TResult Function() refresh,
  }) {
    return signIn(provider);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationProvider provider)? signIn,
    TResult? Function(String username, String name, String? bio,
            String? profile, String? banner)?
        signUp,
    TResult? Function()? signOut,
    TResult? Function()? refresh,
  }) {
    return signIn?.call(provider);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationProvider provider)? signIn,
    TResult Function(String username, String name, String? bio, String? profile,
            String? banner)?
        signUp,
    TResult Function()? signOut,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (signIn != null) {
      return signIn(provider);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationEventSignIn value) signIn,
    required TResult Function(AuthenticationEventSignUp value) signUp,
    required TResult Function(AuthenticationEventSignOut value) signOut,
    required TResult Function(AuthenticationEventRefresh value) refresh,
  }) {
    return signIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationEventSignIn value)? signIn,
    TResult? Function(AuthenticationEventSignUp value)? signUp,
    TResult? Function(AuthenticationEventSignOut value)? signOut,
    TResult? Function(AuthenticationEventRefresh value)? refresh,
  }) {
    return signIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationEventSignIn value)? signIn,
    TResult Function(AuthenticationEventSignUp value)? signUp,
    TResult Function(AuthenticationEventSignOut value)? signOut,
    TResult Function(AuthenticationEventRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (signIn != null) {
      return signIn(this);
    }
    return orElse();
  }
}

abstract class AuthenticationEventSignIn implements AuthenticationEvent {
  factory AuthenticationEventSignIn(final AuthenticationProvider provider) =
      _$AuthenticationEventSignInImpl;

  AuthenticationProvider get provider;
  @JsonKey(ignore: true)
  _$$AuthenticationEventSignInImplCopyWith<_$AuthenticationEventSignInImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticationEventSignUpImplCopyWith<$Res> {
  factory _$$AuthenticationEventSignUpImplCopyWith(
          _$AuthenticationEventSignUpImpl value,
          $Res Function(_$AuthenticationEventSignUpImpl) then) =
      __$$AuthenticationEventSignUpImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String username,
      String name,
      String? bio,
      String? profile,
      String? banner});
}

/// @nodoc
class __$$AuthenticationEventSignUpImplCopyWithImpl<$Res>
    extends _$AuthenticationEventCopyWithImpl<$Res,
        _$AuthenticationEventSignUpImpl>
    implements _$$AuthenticationEventSignUpImplCopyWith<$Res> {
  __$$AuthenticationEventSignUpImplCopyWithImpl(
      _$AuthenticationEventSignUpImpl _value,
      $Res Function(_$AuthenticationEventSignUpImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? name = null,
    Object? bio = freezed,
    Object? profile = freezed,
    Object? banner = freezed,
  }) {
    return _then(_$AuthenticationEventSignUpImpl(
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
    ));
  }
}

/// @nodoc

class _$AuthenticationEventSignUpImpl implements AuthenticationEventSignUp {
  _$AuthenticationEventSignUpImpl(
      {required this.username,
      required this.name,
      this.bio,
      this.profile,
      this.banner});

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
  String toString() {
    return 'AuthenticationEvent.signUp(username: $username, name: $name, bio: $bio, profile: $profile, banner: $banner)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationEventSignUpImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.banner, banner) || other.banner == banner));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, username, name, bio, profile, banner);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationEventSignUpImplCopyWith<_$AuthenticationEventSignUpImpl>
      get copyWith => __$$AuthenticationEventSignUpImplCopyWithImpl<
          _$AuthenticationEventSignUpImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationProvider provider) signIn,
    required TResult Function(String username, String name, String? bio,
            String? profile, String? banner)
        signUp,
    required TResult Function() signOut,
    required TResult Function() refresh,
  }) {
    return signUp(username, name, bio, profile, banner);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationProvider provider)? signIn,
    TResult? Function(String username, String name, String? bio,
            String? profile, String? banner)?
        signUp,
    TResult? Function()? signOut,
    TResult? Function()? refresh,
  }) {
    return signUp?.call(username, name, bio, profile, banner);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationProvider provider)? signIn,
    TResult Function(String username, String name, String? bio, String? profile,
            String? banner)?
        signUp,
    TResult Function()? signOut,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (signUp != null) {
      return signUp(username, name, bio, profile, banner);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationEventSignIn value) signIn,
    required TResult Function(AuthenticationEventSignUp value) signUp,
    required TResult Function(AuthenticationEventSignOut value) signOut,
    required TResult Function(AuthenticationEventRefresh value) refresh,
  }) {
    return signUp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationEventSignIn value)? signIn,
    TResult? Function(AuthenticationEventSignUp value)? signUp,
    TResult? Function(AuthenticationEventSignOut value)? signOut,
    TResult? Function(AuthenticationEventRefresh value)? refresh,
  }) {
    return signUp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationEventSignIn value)? signIn,
    TResult Function(AuthenticationEventSignUp value)? signUp,
    TResult Function(AuthenticationEventSignOut value)? signOut,
    TResult Function(AuthenticationEventRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (signUp != null) {
      return signUp(this);
    }
    return orElse();
  }
}

abstract class AuthenticationEventSignUp implements AuthenticationEvent {
  factory AuthenticationEventSignUp(
      {required final String username,
      required final String name,
      final String? bio,
      final String? profile,
      final String? banner}) = _$AuthenticationEventSignUpImpl;

  String get username;
  String get name;
  String? get bio;
  String? get profile;
  String? get banner;
  @JsonKey(ignore: true)
  _$$AuthenticationEventSignUpImplCopyWith<_$AuthenticationEventSignUpImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticationEventSignOutImplCopyWith<$Res> {
  factory _$$AuthenticationEventSignOutImplCopyWith(
          _$AuthenticationEventSignOutImpl value,
          $Res Function(_$AuthenticationEventSignOutImpl) then) =
      __$$AuthenticationEventSignOutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationEventSignOutImplCopyWithImpl<$Res>
    extends _$AuthenticationEventCopyWithImpl<$Res,
        _$AuthenticationEventSignOutImpl>
    implements _$$AuthenticationEventSignOutImplCopyWith<$Res> {
  __$$AuthenticationEventSignOutImplCopyWithImpl(
      _$AuthenticationEventSignOutImpl _value,
      $Res Function(_$AuthenticationEventSignOutImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationEventSignOutImpl implements AuthenticationEventSignOut {
  const _$AuthenticationEventSignOutImpl();

  @override
  String toString() {
    return 'AuthenticationEvent.signOut()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationEventSignOutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationProvider provider) signIn,
    required TResult Function(String username, String name, String? bio,
            String? profile, String? banner)
        signUp,
    required TResult Function() signOut,
    required TResult Function() refresh,
  }) {
    return signOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationProvider provider)? signIn,
    TResult? Function(String username, String name, String? bio,
            String? profile, String? banner)?
        signUp,
    TResult? Function()? signOut,
    TResult? Function()? refresh,
  }) {
    return signOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationProvider provider)? signIn,
    TResult Function(String username, String name, String? bio, String? profile,
            String? banner)?
        signUp,
    TResult Function()? signOut,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (signOut != null) {
      return signOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationEventSignIn value) signIn,
    required TResult Function(AuthenticationEventSignUp value) signUp,
    required TResult Function(AuthenticationEventSignOut value) signOut,
    required TResult Function(AuthenticationEventRefresh value) refresh,
  }) {
    return signOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationEventSignIn value)? signIn,
    TResult? Function(AuthenticationEventSignUp value)? signUp,
    TResult? Function(AuthenticationEventSignOut value)? signOut,
    TResult? Function(AuthenticationEventRefresh value)? refresh,
  }) {
    return signOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationEventSignIn value)? signIn,
    TResult Function(AuthenticationEventSignUp value)? signUp,
    TResult Function(AuthenticationEventSignOut value)? signOut,
    TResult Function(AuthenticationEventRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (signOut != null) {
      return signOut(this);
    }
    return orElse();
  }
}

abstract class AuthenticationEventSignOut implements AuthenticationEvent {
  const factory AuthenticationEventSignOut() = _$AuthenticationEventSignOutImpl;
}

/// @nodoc
abstract class _$$AuthenticationEventRefreshImplCopyWith<$Res> {
  factory _$$AuthenticationEventRefreshImplCopyWith(
          _$AuthenticationEventRefreshImpl value,
          $Res Function(_$AuthenticationEventRefreshImpl) then) =
      __$$AuthenticationEventRefreshImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationEventRefreshImplCopyWithImpl<$Res>
    extends _$AuthenticationEventCopyWithImpl<$Res,
        _$AuthenticationEventRefreshImpl>
    implements _$$AuthenticationEventRefreshImplCopyWith<$Res> {
  __$$AuthenticationEventRefreshImplCopyWithImpl(
      _$AuthenticationEventRefreshImpl _value,
      $Res Function(_$AuthenticationEventRefreshImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationEventRefreshImpl implements AuthenticationEventRefresh {
  const _$AuthenticationEventRefreshImpl();

  @override
  String toString() {
    return 'AuthenticationEvent.refresh()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationEventRefreshImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationProvider provider) signIn,
    required TResult Function(String username, String name, String? bio,
            String? profile, String? banner)
        signUp,
    required TResult Function() signOut,
    required TResult Function() refresh,
  }) {
    return refresh();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationProvider provider)? signIn,
    TResult? Function(String username, String name, String? bio,
            String? profile, String? banner)?
        signUp,
    TResult? Function()? signOut,
    TResult? Function()? refresh,
  }) {
    return refresh?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationProvider provider)? signIn,
    TResult Function(String username, String name, String? bio, String? profile,
            String? banner)?
        signUp,
    TResult Function()? signOut,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationEventSignIn value) signIn,
    required TResult Function(AuthenticationEventSignUp value) signUp,
    required TResult Function(AuthenticationEventSignOut value) signOut,
    required TResult Function(AuthenticationEventRefresh value) refresh,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationEventSignIn value)? signIn,
    TResult? Function(AuthenticationEventSignUp value)? signUp,
    TResult? Function(AuthenticationEventSignOut value)? signOut,
    TResult? Function(AuthenticationEventRefresh value)? refresh,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationEventSignIn value)? signIn,
    TResult Function(AuthenticationEventSignUp value)? signUp,
    TResult Function(AuthenticationEventSignOut value)? signOut,
    TResult Function(AuthenticationEventRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class AuthenticationEventRefresh implements AuthenticationEvent {
  const factory AuthenticationEventRefresh() = _$AuthenticationEventRefreshImpl;
}
