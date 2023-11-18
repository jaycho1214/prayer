// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthenticationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(AuthenticationProvider provider) signInLoading,
    required TResult Function() signInError,
    required TResult Function() signedIn,
    required TResult Function(PUser user) signedUp,
    required TResult Function(String message) signUpError,
    required TResult Function() signUpLoading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(AuthenticationProvider provider)? signInLoading,
    TResult? Function()? signInError,
    TResult? Function()? signedIn,
    TResult? Function(PUser user)? signedUp,
    TResult? Function(String message)? signUpError,
    TResult? Function()? signUpLoading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(AuthenticationProvider provider)? signInLoading,
    TResult Function()? signInError,
    TResult Function()? signedIn,
    TResult Function(PUser user)? signedUp,
    TResult Function(String message)? signUpError,
    TResult Function()? signUpLoading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationStateIdle value) idle,
    required TResult Function(AuthenticationStateSignInLoading value)
        signInLoading,
    required TResult Function(AuthenticationStateSignInError value) signInError,
    required TResult Function(AuthenticationStateSignedIn value) signedIn,
    required TResult Function(AuthenticationStateSignedUp value) signedUp,
    required TResult Function(AuthenticationStateSignUpError value) signUpError,
    required TResult Function(AuthenticationStateSignUpLoading value)
        signUpLoading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationStateIdle value)? idle,
    TResult? Function(AuthenticationStateSignInLoading value)? signInLoading,
    TResult? Function(AuthenticationStateSignInError value)? signInError,
    TResult? Function(AuthenticationStateSignedIn value)? signedIn,
    TResult? Function(AuthenticationStateSignedUp value)? signedUp,
    TResult? Function(AuthenticationStateSignUpError value)? signUpError,
    TResult? Function(AuthenticationStateSignUpLoading value)? signUpLoading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationStateIdle value)? idle,
    TResult Function(AuthenticationStateSignInLoading value)? signInLoading,
    TResult Function(AuthenticationStateSignInError value)? signInError,
    TResult Function(AuthenticationStateSignedIn value)? signedIn,
    TResult Function(AuthenticationStateSignedUp value)? signedUp,
    TResult Function(AuthenticationStateSignUpError value)? signUpError,
    TResult Function(AuthenticationStateSignUpLoading value)? signUpLoading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationStateCopyWith(
          AuthenticationState value, $Res Function(AuthenticationState) then) =
      _$AuthenticationStateCopyWithImpl<$Res, AuthenticationState>;
}

/// @nodoc
class _$AuthenticationStateCopyWithImpl<$Res, $Val extends AuthenticationState>
    implements $AuthenticationStateCopyWith<$Res> {
  _$AuthenticationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AuthenticationStateIdleImplCopyWith<$Res> {
  factory _$$AuthenticationStateIdleImplCopyWith(
          _$AuthenticationStateIdleImpl value,
          $Res Function(_$AuthenticationStateIdleImpl) then) =
      __$$AuthenticationStateIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationStateIdleImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res,
        _$AuthenticationStateIdleImpl>
    implements _$$AuthenticationStateIdleImplCopyWith<$Res> {
  __$$AuthenticationStateIdleImplCopyWithImpl(
      _$AuthenticationStateIdleImpl _value,
      $Res Function(_$AuthenticationStateIdleImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationStateIdleImpl implements AuthenticationStateIdle {
  const _$AuthenticationStateIdleImpl();

  @override
  String toString() {
    return 'AuthenticationState.idle()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationStateIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(AuthenticationProvider provider) signInLoading,
    required TResult Function() signInError,
    required TResult Function() signedIn,
    required TResult Function(PUser user) signedUp,
    required TResult Function(String message) signUpError,
    required TResult Function() signUpLoading,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(AuthenticationProvider provider)? signInLoading,
    TResult? Function()? signInError,
    TResult? Function()? signedIn,
    TResult? Function(PUser user)? signedUp,
    TResult? Function(String message)? signUpError,
    TResult? Function()? signUpLoading,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(AuthenticationProvider provider)? signInLoading,
    TResult Function()? signInError,
    TResult Function()? signedIn,
    TResult Function(PUser user)? signedUp,
    TResult Function(String message)? signUpError,
    TResult Function()? signUpLoading,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationStateIdle value) idle,
    required TResult Function(AuthenticationStateSignInLoading value)
        signInLoading,
    required TResult Function(AuthenticationStateSignInError value) signInError,
    required TResult Function(AuthenticationStateSignedIn value) signedIn,
    required TResult Function(AuthenticationStateSignedUp value) signedUp,
    required TResult Function(AuthenticationStateSignUpError value) signUpError,
    required TResult Function(AuthenticationStateSignUpLoading value)
        signUpLoading,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationStateIdle value)? idle,
    TResult? Function(AuthenticationStateSignInLoading value)? signInLoading,
    TResult? Function(AuthenticationStateSignInError value)? signInError,
    TResult? Function(AuthenticationStateSignedIn value)? signedIn,
    TResult? Function(AuthenticationStateSignedUp value)? signedUp,
    TResult? Function(AuthenticationStateSignUpError value)? signUpError,
    TResult? Function(AuthenticationStateSignUpLoading value)? signUpLoading,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationStateIdle value)? idle,
    TResult Function(AuthenticationStateSignInLoading value)? signInLoading,
    TResult Function(AuthenticationStateSignInError value)? signInError,
    TResult Function(AuthenticationStateSignedIn value)? signedIn,
    TResult Function(AuthenticationStateSignedUp value)? signedUp,
    TResult Function(AuthenticationStateSignUpError value)? signUpError,
    TResult Function(AuthenticationStateSignUpLoading value)? signUpLoading,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class AuthenticationStateIdle implements AuthenticationState {
  const factory AuthenticationStateIdle() = _$AuthenticationStateIdleImpl;
}

/// @nodoc
abstract class _$$AuthenticationStateSignInLoadingImplCopyWith<$Res> {
  factory _$$AuthenticationStateSignInLoadingImplCopyWith(
          _$AuthenticationStateSignInLoadingImpl value,
          $Res Function(_$AuthenticationStateSignInLoadingImpl) then) =
      __$$AuthenticationStateSignInLoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AuthenticationProvider provider});
}

/// @nodoc
class __$$AuthenticationStateSignInLoadingImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res,
        _$AuthenticationStateSignInLoadingImpl>
    implements _$$AuthenticationStateSignInLoadingImplCopyWith<$Res> {
  __$$AuthenticationStateSignInLoadingImplCopyWithImpl(
      _$AuthenticationStateSignInLoadingImpl _value,
      $Res Function(_$AuthenticationStateSignInLoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
  }) {
    return _then(_$AuthenticationStateSignInLoadingImpl(
      null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as AuthenticationProvider,
    ));
  }
}

/// @nodoc

class _$AuthenticationStateSignInLoadingImpl
    implements AuthenticationStateSignInLoading {
  _$AuthenticationStateSignInLoadingImpl(this.provider);

  @override
  final AuthenticationProvider provider;

  @override
  String toString() {
    return 'AuthenticationState.signInLoading(provider: $provider)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationStateSignInLoadingImpl &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @override
  int get hashCode => Object.hash(runtimeType, provider);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationStateSignInLoadingImplCopyWith<
          _$AuthenticationStateSignInLoadingImpl>
      get copyWith => __$$AuthenticationStateSignInLoadingImplCopyWithImpl<
          _$AuthenticationStateSignInLoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(AuthenticationProvider provider) signInLoading,
    required TResult Function() signInError,
    required TResult Function() signedIn,
    required TResult Function(PUser user) signedUp,
    required TResult Function(String message) signUpError,
    required TResult Function() signUpLoading,
  }) {
    return signInLoading(provider);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(AuthenticationProvider provider)? signInLoading,
    TResult? Function()? signInError,
    TResult? Function()? signedIn,
    TResult? Function(PUser user)? signedUp,
    TResult? Function(String message)? signUpError,
    TResult? Function()? signUpLoading,
  }) {
    return signInLoading?.call(provider);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(AuthenticationProvider provider)? signInLoading,
    TResult Function()? signInError,
    TResult Function()? signedIn,
    TResult Function(PUser user)? signedUp,
    TResult Function(String message)? signUpError,
    TResult Function()? signUpLoading,
    required TResult orElse(),
  }) {
    if (signInLoading != null) {
      return signInLoading(provider);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationStateIdle value) idle,
    required TResult Function(AuthenticationStateSignInLoading value)
        signInLoading,
    required TResult Function(AuthenticationStateSignInError value) signInError,
    required TResult Function(AuthenticationStateSignedIn value) signedIn,
    required TResult Function(AuthenticationStateSignedUp value) signedUp,
    required TResult Function(AuthenticationStateSignUpError value) signUpError,
    required TResult Function(AuthenticationStateSignUpLoading value)
        signUpLoading,
  }) {
    return signInLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationStateIdle value)? idle,
    TResult? Function(AuthenticationStateSignInLoading value)? signInLoading,
    TResult? Function(AuthenticationStateSignInError value)? signInError,
    TResult? Function(AuthenticationStateSignedIn value)? signedIn,
    TResult? Function(AuthenticationStateSignedUp value)? signedUp,
    TResult? Function(AuthenticationStateSignUpError value)? signUpError,
    TResult? Function(AuthenticationStateSignUpLoading value)? signUpLoading,
  }) {
    return signInLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationStateIdle value)? idle,
    TResult Function(AuthenticationStateSignInLoading value)? signInLoading,
    TResult Function(AuthenticationStateSignInError value)? signInError,
    TResult Function(AuthenticationStateSignedIn value)? signedIn,
    TResult Function(AuthenticationStateSignedUp value)? signedUp,
    TResult Function(AuthenticationStateSignUpError value)? signUpError,
    TResult Function(AuthenticationStateSignUpLoading value)? signUpLoading,
    required TResult orElse(),
  }) {
    if (signInLoading != null) {
      return signInLoading(this);
    }
    return orElse();
  }
}

abstract class AuthenticationStateSignInLoading implements AuthenticationState {
  factory AuthenticationStateSignInLoading(
          final AuthenticationProvider provider) =
      _$AuthenticationStateSignInLoadingImpl;

  AuthenticationProvider get provider;
  @JsonKey(ignore: true)
  _$$AuthenticationStateSignInLoadingImplCopyWith<
          _$AuthenticationStateSignInLoadingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticationStateSignInErrorImplCopyWith<$Res> {
  factory _$$AuthenticationStateSignInErrorImplCopyWith(
          _$AuthenticationStateSignInErrorImpl value,
          $Res Function(_$AuthenticationStateSignInErrorImpl) then) =
      __$$AuthenticationStateSignInErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationStateSignInErrorImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res,
        _$AuthenticationStateSignInErrorImpl>
    implements _$$AuthenticationStateSignInErrorImplCopyWith<$Res> {
  __$$AuthenticationStateSignInErrorImplCopyWithImpl(
      _$AuthenticationStateSignInErrorImpl _value,
      $Res Function(_$AuthenticationStateSignInErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationStateSignInErrorImpl
    implements AuthenticationStateSignInError {
  const _$AuthenticationStateSignInErrorImpl();

  @override
  String toString() {
    return 'AuthenticationState.signInError()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationStateSignInErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(AuthenticationProvider provider) signInLoading,
    required TResult Function() signInError,
    required TResult Function() signedIn,
    required TResult Function(PUser user) signedUp,
    required TResult Function(String message) signUpError,
    required TResult Function() signUpLoading,
  }) {
    return signInError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(AuthenticationProvider provider)? signInLoading,
    TResult? Function()? signInError,
    TResult? Function()? signedIn,
    TResult? Function(PUser user)? signedUp,
    TResult? Function(String message)? signUpError,
    TResult? Function()? signUpLoading,
  }) {
    return signInError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(AuthenticationProvider provider)? signInLoading,
    TResult Function()? signInError,
    TResult Function()? signedIn,
    TResult Function(PUser user)? signedUp,
    TResult Function(String message)? signUpError,
    TResult Function()? signUpLoading,
    required TResult orElse(),
  }) {
    if (signInError != null) {
      return signInError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationStateIdle value) idle,
    required TResult Function(AuthenticationStateSignInLoading value)
        signInLoading,
    required TResult Function(AuthenticationStateSignInError value) signInError,
    required TResult Function(AuthenticationStateSignedIn value) signedIn,
    required TResult Function(AuthenticationStateSignedUp value) signedUp,
    required TResult Function(AuthenticationStateSignUpError value) signUpError,
    required TResult Function(AuthenticationStateSignUpLoading value)
        signUpLoading,
  }) {
    return signInError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationStateIdle value)? idle,
    TResult? Function(AuthenticationStateSignInLoading value)? signInLoading,
    TResult? Function(AuthenticationStateSignInError value)? signInError,
    TResult? Function(AuthenticationStateSignedIn value)? signedIn,
    TResult? Function(AuthenticationStateSignedUp value)? signedUp,
    TResult? Function(AuthenticationStateSignUpError value)? signUpError,
    TResult? Function(AuthenticationStateSignUpLoading value)? signUpLoading,
  }) {
    return signInError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationStateIdle value)? idle,
    TResult Function(AuthenticationStateSignInLoading value)? signInLoading,
    TResult Function(AuthenticationStateSignInError value)? signInError,
    TResult Function(AuthenticationStateSignedIn value)? signedIn,
    TResult Function(AuthenticationStateSignedUp value)? signedUp,
    TResult Function(AuthenticationStateSignUpError value)? signUpError,
    TResult Function(AuthenticationStateSignUpLoading value)? signUpLoading,
    required TResult orElse(),
  }) {
    if (signInError != null) {
      return signInError(this);
    }
    return orElse();
  }
}

abstract class AuthenticationStateSignInError implements AuthenticationState {
  const factory AuthenticationStateSignInError() =
      _$AuthenticationStateSignInErrorImpl;
}

/// @nodoc
abstract class _$$AuthenticationStateSignedInImplCopyWith<$Res> {
  factory _$$AuthenticationStateSignedInImplCopyWith(
          _$AuthenticationStateSignedInImpl value,
          $Res Function(_$AuthenticationStateSignedInImpl) then) =
      __$$AuthenticationStateSignedInImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationStateSignedInImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res,
        _$AuthenticationStateSignedInImpl>
    implements _$$AuthenticationStateSignedInImplCopyWith<$Res> {
  __$$AuthenticationStateSignedInImplCopyWithImpl(
      _$AuthenticationStateSignedInImpl _value,
      $Res Function(_$AuthenticationStateSignedInImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationStateSignedInImpl implements AuthenticationStateSignedIn {
  const _$AuthenticationStateSignedInImpl();

  @override
  String toString() {
    return 'AuthenticationState.signedIn()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationStateSignedInImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(AuthenticationProvider provider) signInLoading,
    required TResult Function() signInError,
    required TResult Function() signedIn,
    required TResult Function(PUser user) signedUp,
    required TResult Function(String message) signUpError,
    required TResult Function() signUpLoading,
  }) {
    return signedIn();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(AuthenticationProvider provider)? signInLoading,
    TResult? Function()? signInError,
    TResult? Function()? signedIn,
    TResult? Function(PUser user)? signedUp,
    TResult? Function(String message)? signUpError,
    TResult? Function()? signUpLoading,
  }) {
    return signedIn?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(AuthenticationProvider provider)? signInLoading,
    TResult Function()? signInError,
    TResult Function()? signedIn,
    TResult Function(PUser user)? signedUp,
    TResult Function(String message)? signUpError,
    TResult Function()? signUpLoading,
    required TResult orElse(),
  }) {
    if (signedIn != null) {
      return signedIn();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationStateIdle value) idle,
    required TResult Function(AuthenticationStateSignInLoading value)
        signInLoading,
    required TResult Function(AuthenticationStateSignInError value) signInError,
    required TResult Function(AuthenticationStateSignedIn value) signedIn,
    required TResult Function(AuthenticationStateSignedUp value) signedUp,
    required TResult Function(AuthenticationStateSignUpError value) signUpError,
    required TResult Function(AuthenticationStateSignUpLoading value)
        signUpLoading,
  }) {
    return signedIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationStateIdle value)? idle,
    TResult? Function(AuthenticationStateSignInLoading value)? signInLoading,
    TResult? Function(AuthenticationStateSignInError value)? signInError,
    TResult? Function(AuthenticationStateSignedIn value)? signedIn,
    TResult? Function(AuthenticationStateSignedUp value)? signedUp,
    TResult? Function(AuthenticationStateSignUpError value)? signUpError,
    TResult? Function(AuthenticationStateSignUpLoading value)? signUpLoading,
  }) {
    return signedIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationStateIdle value)? idle,
    TResult Function(AuthenticationStateSignInLoading value)? signInLoading,
    TResult Function(AuthenticationStateSignInError value)? signInError,
    TResult Function(AuthenticationStateSignedIn value)? signedIn,
    TResult Function(AuthenticationStateSignedUp value)? signedUp,
    TResult Function(AuthenticationStateSignUpError value)? signUpError,
    TResult Function(AuthenticationStateSignUpLoading value)? signUpLoading,
    required TResult orElse(),
  }) {
    if (signedIn != null) {
      return signedIn(this);
    }
    return orElse();
  }
}

abstract class AuthenticationStateSignedIn implements AuthenticationState {
  const factory AuthenticationStateSignedIn() =
      _$AuthenticationStateSignedInImpl;
}

/// @nodoc
abstract class _$$AuthenticationStateSignedUpImplCopyWith<$Res> {
  factory _$$AuthenticationStateSignedUpImplCopyWith(
          _$AuthenticationStateSignedUpImpl value,
          $Res Function(_$AuthenticationStateSignedUpImpl) then) =
      __$$AuthenticationStateSignedUpImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PUser user});

  $PUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$AuthenticationStateSignedUpImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res,
        _$AuthenticationStateSignedUpImpl>
    implements _$$AuthenticationStateSignedUpImplCopyWith<$Res> {
  __$$AuthenticationStateSignedUpImplCopyWithImpl(
      _$AuthenticationStateSignedUpImpl _value,
      $Res Function(_$AuthenticationStateSignedUpImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$AuthenticationStateSignedUpImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as PUser,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $PUserCopyWith<$Res> get user {
    return $PUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$AuthenticationStateSignedUpImpl implements AuthenticationStateSignedUp {
  const _$AuthenticationStateSignedUpImpl(this.user);

  @override
  final PUser user;

  @override
  String toString() {
    return 'AuthenticationState.signedUp(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationStateSignedUpImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationStateSignedUpImplCopyWith<_$AuthenticationStateSignedUpImpl>
      get copyWith => __$$AuthenticationStateSignedUpImplCopyWithImpl<
          _$AuthenticationStateSignedUpImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(AuthenticationProvider provider) signInLoading,
    required TResult Function() signInError,
    required TResult Function() signedIn,
    required TResult Function(PUser user) signedUp,
    required TResult Function(String message) signUpError,
    required TResult Function() signUpLoading,
  }) {
    return signedUp(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(AuthenticationProvider provider)? signInLoading,
    TResult? Function()? signInError,
    TResult? Function()? signedIn,
    TResult? Function(PUser user)? signedUp,
    TResult? Function(String message)? signUpError,
    TResult? Function()? signUpLoading,
  }) {
    return signedUp?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(AuthenticationProvider provider)? signInLoading,
    TResult Function()? signInError,
    TResult Function()? signedIn,
    TResult Function(PUser user)? signedUp,
    TResult Function(String message)? signUpError,
    TResult Function()? signUpLoading,
    required TResult orElse(),
  }) {
    if (signedUp != null) {
      return signedUp(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationStateIdle value) idle,
    required TResult Function(AuthenticationStateSignInLoading value)
        signInLoading,
    required TResult Function(AuthenticationStateSignInError value) signInError,
    required TResult Function(AuthenticationStateSignedIn value) signedIn,
    required TResult Function(AuthenticationStateSignedUp value) signedUp,
    required TResult Function(AuthenticationStateSignUpError value) signUpError,
    required TResult Function(AuthenticationStateSignUpLoading value)
        signUpLoading,
  }) {
    return signedUp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationStateIdle value)? idle,
    TResult? Function(AuthenticationStateSignInLoading value)? signInLoading,
    TResult? Function(AuthenticationStateSignInError value)? signInError,
    TResult? Function(AuthenticationStateSignedIn value)? signedIn,
    TResult? Function(AuthenticationStateSignedUp value)? signedUp,
    TResult? Function(AuthenticationStateSignUpError value)? signUpError,
    TResult? Function(AuthenticationStateSignUpLoading value)? signUpLoading,
  }) {
    return signedUp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationStateIdle value)? idle,
    TResult Function(AuthenticationStateSignInLoading value)? signInLoading,
    TResult Function(AuthenticationStateSignInError value)? signInError,
    TResult Function(AuthenticationStateSignedIn value)? signedIn,
    TResult Function(AuthenticationStateSignedUp value)? signedUp,
    TResult Function(AuthenticationStateSignUpError value)? signUpError,
    TResult Function(AuthenticationStateSignUpLoading value)? signUpLoading,
    required TResult orElse(),
  }) {
    if (signedUp != null) {
      return signedUp(this);
    }
    return orElse();
  }
}

abstract class AuthenticationStateSignedUp implements AuthenticationState {
  const factory AuthenticationStateSignedUp(final PUser user) =
      _$AuthenticationStateSignedUpImpl;

  PUser get user;
  @JsonKey(ignore: true)
  _$$AuthenticationStateSignedUpImplCopyWith<_$AuthenticationStateSignedUpImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticationStateSignUpErrorImplCopyWith<$Res> {
  factory _$$AuthenticationStateSignUpErrorImplCopyWith(
          _$AuthenticationStateSignUpErrorImpl value,
          $Res Function(_$AuthenticationStateSignUpErrorImpl) then) =
      __$$AuthenticationStateSignUpErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthenticationStateSignUpErrorImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res,
        _$AuthenticationStateSignUpErrorImpl>
    implements _$$AuthenticationStateSignUpErrorImplCopyWith<$Res> {
  __$$AuthenticationStateSignUpErrorImplCopyWithImpl(
      _$AuthenticationStateSignUpErrorImpl _value,
      $Res Function(_$AuthenticationStateSignUpErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AuthenticationStateSignUpErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthenticationStateSignUpErrorImpl
    implements AuthenticationStateSignUpError {
  const _$AuthenticationStateSignUpErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AuthenticationState.signUpError(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationStateSignUpErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationStateSignUpErrorImplCopyWith<
          _$AuthenticationStateSignUpErrorImpl>
      get copyWith => __$$AuthenticationStateSignUpErrorImplCopyWithImpl<
          _$AuthenticationStateSignUpErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(AuthenticationProvider provider) signInLoading,
    required TResult Function() signInError,
    required TResult Function() signedIn,
    required TResult Function(PUser user) signedUp,
    required TResult Function(String message) signUpError,
    required TResult Function() signUpLoading,
  }) {
    return signUpError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(AuthenticationProvider provider)? signInLoading,
    TResult? Function()? signInError,
    TResult? Function()? signedIn,
    TResult? Function(PUser user)? signedUp,
    TResult? Function(String message)? signUpError,
    TResult? Function()? signUpLoading,
  }) {
    return signUpError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(AuthenticationProvider provider)? signInLoading,
    TResult Function()? signInError,
    TResult Function()? signedIn,
    TResult Function(PUser user)? signedUp,
    TResult Function(String message)? signUpError,
    TResult Function()? signUpLoading,
    required TResult orElse(),
  }) {
    if (signUpError != null) {
      return signUpError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationStateIdle value) idle,
    required TResult Function(AuthenticationStateSignInLoading value)
        signInLoading,
    required TResult Function(AuthenticationStateSignInError value) signInError,
    required TResult Function(AuthenticationStateSignedIn value) signedIn,
    required TResult Function(AuthenticationStateSignedUp value) signedUp,
    required TResult Function(AuthenticationStateSignUpError value) signUpError,
    required TResult Function(AuthenticationStateSignUpLoading value)
        signUpLoading,
  }) {
    return signUpError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationStateIdle value)? idle,
    TResult? Function(AuthenticationStateSignInLoading value)? signInLoading,
    TResult? Function(AuthenticationStateSignInError value)? signInError,
    TResult? Function(AuthenticationStateSignedIn value)? signedIn,
    TResult? Function(AuthenticationStateSignedUp value)? signedUp,
    TResult? Function(AuthenticationStateSignUpError value)? signUpError,
    TResult? Function(AuthenticationStateSignUpLoading value)? signUpLoading,
  }) {
    return signUpError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationStateIdle value)? idle,
    TResult Function(AuthenticationStateSignInLoading value)? signInLoading,
    TResult Function(AuthenticationStateSignInError value)? signInError,
    TResult Function(AuthenticationStateSignedIn value)? signedIn,
    TResult Function(AuthenticationStateSignedUp value)? signedUp,
    TResult Function(AuthenticationStateSignUpError value)? signUpError,
    TResult Function(AuthenticationStateSignUpLoading value)? signUpLoading,
    required TResult orElse(),
  }) {
    if (signUpError != null) {
      return signUpError(this);
    }
    return orElse();
  }
}

abstract class AuthenticationStateSignUpError implements AuthenticationState {
  const factory AuthenticationStateSignUpError(final String message) =
      _$AuthenticationStateSignUpErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$AuthenticationStateSignUpErrorImplCopyWith<
          _$AuthenticationStateSignUpErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticationStateSignUpLoadingImplCopyWith<$Res> {
  factory _$$AuthenticationStateSignUpLoadingImplCopyWith(
          _$AuthenticationStateSignUpLoadingImpl value,
          $Res Function(_$AuthenticationStateSignUpLoadingImpl) then) =
      __$$AuthenticationStateSignUpLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationStateSignUpLoadingImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res,
        _$AuthenticationStateSignUpLoadingImpl>
    implements _$$AuthenticationStateSignUpLoadingImplCopyWith<$Res> {
  __$$AuthenticationStateSignUpLoadingImplCopyWithImpl(
      _$AuthenticationStateSignUpLoadingImpl _value,
      $Res Function(_$AuthenticationStateSignUpLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationStateSignUpLoadingImpl
    implements AuthenticationStateSignUpLoading {
  _$AuthenticationStateSignUpLoadingImpl();

  @override
  String toString() {
    return 'AuthenticationState.signUpLoading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationStateSignUpLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(AuthenticationProvider provider) signInLoading,
    required TResult Function() signInError,
    required TResult Function() signedIn,
    required TResult Function(PUser user) signedUp,
    required TResult Function(String message) signUpError,
    required TResult Function() signUpLoading,
  }) {
    return signUpLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(AuthenticationProvider provider)? signInLoading,
    TResult? Function()? signInError,
    TResult? Function()? signedIn,
    TResult? Function(PUser user)? signedUp,
    TResult? Function(String message)? signUpError,
    TResult? Function()? signUpLoading,
  }) {
    return signUpLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(AuthenticationProvider provider)? signInLoading,
    TResult Function()? signInError,
    TResult Function()? signedIn,
    TResult Function(PUser user)? signedUp,
    TResult Function(String message)? signUpError,
    TResult Function()? signUpLoading,
    required TResult orElse(),
  }) {
    if (signUpLoading != null) {
      return signUpLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthenticationStateIdle value) idle,
    required TResult Function(AuthenticationStateSignInLoading value)
        signInLoading,
    required TResult Function(AuthenticationStateSignInError value) signInError,
    required TResult Function(AuthenticationStateSignedIn value) signedIn,
    required TResult Function(AuthenticationStateSignedUp value) signedUp,
    required TResult Function(AuthenticationStateSignUpError value) signUpError,
    required TResult Function(AuthenticationStateSignUpLoading value)
        signUpLoading,
  }) {
    return signUpLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthenticationStateIdle value)? idle,
    TResult? Function(AuthenticationStateSignInLoading value)? signInLoading,
    TResult? Function(AuthenticationStateSignInError value)? signInError,
    TResult? Function(AuthenticationStateSignedIn value)? signedIn,
    TResult? Function(AuthenticationStateSignedUp value)? signedUp,
    TResult? Function(AuthenticationStateSignUpError value)? signUpError,
    TResult? Function(AuthenticationStateSignUpLoading value)? signUpLoading,
  }) {
    return signUpLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthenticationStateIdle value)? idle,
    TResult Function(AuthenticationStateSignInLoading value)? signInLoading,
    TResult Function(AuthenticationStateSignInError value)? signInError,
    TResult Function(AuthenticationStateSignedIn value)? signedIn,
    TResult Function(AuthenticationStateSignedUp value)? signedUp,
    TResult Function(AuthenticationStateSignUpError value)? signUpError,
    TResult Function(AuthenticationStateSignUpLoading value)? signUpLoading,
    required TResult orElse(),
  }) {
    if (signUpLoading != null) {
      return signUpLoading(this);
    }
    return orElse();
  }
}

abstract class AuthenticationStateSignUpLoading implements AuthenticationState {
  factory AuthenticationStateSignUpLoading() =
      _$AuthenticationStateSignUpLoadingImpl;
}
