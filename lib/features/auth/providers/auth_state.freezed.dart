// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() signedOut,
    required TResult Function() signedIn,
    required TResult Function(PUser user) signedUp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? signedOut,
    TResult? Function()? signedIn,
    TResult? Function(PUser user)? signedUp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? signedOut,
    TResult Function()? signedIn,
    TResult Function(PUser user)? signedUp,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateSignedOut value) signedOut,
    required TResult Function(AuthStateSignedIn value) signedIn,
    required TResult Function(AuthStateSignedUp value) signedUp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateSignedOut value)? signedOut,
    TResult? Function(AuthStateSignedIn value)? signedIn,
    TResult? Function(AuthStateSignedUp value)? signedUp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateSignedOut value)? signedOut,
    TResult Function(AuthStateSignedIn value)? signedIn,
    TResult Function(AuthStateSignedUp value)? signedUp,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AuthStateSignedOutImplCopyWith<$Res> {
  factory _$$AuthStateSignedOutImplCopyWith(_$AuthStateSignedOutImpl value,
          $Res Function(_$AuthStateSignedOutImpl) then) =
      __$$AuthStateSignedOutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthStateSignedOutImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateSignedOutImpl>
    implements _$$AuthStateSignedOutImplCopyWith<$Res> {
  __$$AuthStateSignedOutImplCopyWithImpl(_$AuthStateSignedOutImpl _value,
      $Res Function(_$AuthStateSignedOutImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthStateSignedOutImpl implements AuthStateSignedOut {
  const _$AuthStateSignedOutImpl();

  @override
  String toString() {
    return 'AuthState.signedOut()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthStateSignedOutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() signedOut,
    required TResult Function() signedIn,
    required TResult Function(PUser user) signedUp,
  }) {
    return signedOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? signedOut,
    TResult? Function()? signedIn,
    TResult? Function(PUser user)? signedUp,
  }) {
    return signedOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? signedOut,
    TResult Function()? signedIn,
    TResult Function(PUser user)? signedUp,
    required TResult orElse(),
  }) {
    if (signedOut != null) {
      return signedOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateSignedOut value) signedOut,
    required TResult Function(AuthStateSignedIn value) signedIn,
    required TResult Function(AuthStateSignedUp value) signedUp,
  }) {
    return signedOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateSignedOut value)? signedOut,
    TResult? Function(AuthStateSignedIn value)? signedIn,
    TResult? Function(AuthStateSignedUp value)? signedUp,
  }) {
    return signedOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateSignedOut value)? signedOut,
    TResult Function(AuthStateSignedIn value)? signedIn,
    TResult Function(AuthStateSignedUp value)? signedUp,
    required TResult orElse(),
  }) {
    if (signedOut != null) {
      return signedOut(this);
    }
    return orElse();
  }
}

abstract class AuthStateSignedOut implements AuthState {
  const factory AuthStateSignedOut() = _$AuthStateSignedOutImpl;
}

/// @nodoc
abstract class _$$AuthStateSignedInImplCopyWith<$Res> {
  factory _$$AuthStateSignedInImplCopyWith(_$AuthStateSignedInImpl value,
          $Res Function(_$AuthStateSignedInImpl) then) =
      __$$AuthStateSignedInImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthStateSignedInImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateSignedInImpl>
    implements _$$AuthStateSignedInImplCopyWith<$Res> {
  __$$AuthStateSignedInImplCopyWithImpl(_$AuthStateSignedInImpl _value,
      $Res Function(_$AuthStateSignedInImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthStateSignedInImpl implements AuthStateSignedIn {
  const _$AuthStateSignedInImpl();

  @override
  String toString() {
    return 'AuthState.signedIn()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthStateSignedInImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() signedOut,
    required TResult Function() signedIn,
    required TResult Function(PUser user) signedUp,
  }) {
    return signedIn();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? signedOut,
    TResult? Function()? signedIn,
    TResult? Function(PUser user)? signedUp,
  }) {
    return signedIn?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? signedOut,
    TResult Function()? signedIn,
    TResult Function(PUser user)? signedUp,
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
    required TResult Function(AuthStateSignedOut value) signedOut,
    required TResult Function(AuthStateSignedIn value) signedIn,
    required TResult Function(AuthStateSignedUp value) signedUp,
  }) {
    return signedIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateSignedOut value)? signedOut,
    TResult? Function(AuthStateSignedIn value)? signedIn,
    TResult? Function(AuthStateSignedUp value)? signedUp,
  }) {
    return signedIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateSignedOut value)? signedOut,
    TResult Function(AuthStateSignedIn value)? signedIn,
    TResult Function(AuthStateSignedUp value)? signedUp,
    required TResult orElse(),
  }) {
    if (signedIn != null) {
      return signedIn(this);
    }
    return orElse();
  }
}

abstract class AuthStateSignedIn implements AuthState {
  const factory AuthStateSignedIn() = _$AuthStateSignedInImpl;
}

/// @nodoc
abstract class _$$AuthStateSignedUpImplCopyWith<$Res> {
  factory _$$AuthStateSignedUpImplCopyWith(_$AuthStateSignedUpImpl value,
          $Res Function(_$AuthStateSignedUpImpl) then) =
      __$$AuthStateSignedUpImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PUser user});

  $PUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$AuthStateSignedUpImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateSignedUpImpl>
    implements _$$AuthStateSignedUpImplCopyWith<$Res> {
  __$$AuthStateSignedUpImplCopyWithImpl(_$AuthStateSignedUpImpl _value,
      $Res Function(_$AuthStateSignedUpImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$AuthStateSignedUpImpl(
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

class _$AuthStateSignedUpImpl implements AuthStateSignedUp {
  const _$AuthStateSignedUpImpl(this.user);

  @override
  final PUser user;

  @override
  String toString() {
    return 'AuthState.signedUp(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateSignedUpImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateSignedUpImplCopyWith<_$AuthStateSignedUpImpl> get copyWith =>
      __$$AuthStateSignedUpImplCopyWithImpl<_$AuthStateSignedUpImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() signedOut,
    required TResult Function() signedIn,
    required TResult Function(PUser user) signedUp,
  }) {
    return signedUp(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? signedOut,
    TResult? Function()? signedIn,
    TResult? Function(PUser user)? signedUp,
  }) {
    return signedUp?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? signedOut,
    TResult Function()? signedIn,
    TResult Function(PUser user)? signedUp,
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
    required TResult Function(AuthStateSignedOut value) signedOut,
    required TResult Function(AuthStateSignedIn value) signedIn,
    required TResult Function(AuthStateSignedUp value) signedUp,
  }) {
    return signedUp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateSignedOut value)? signedOut,
    TResult? Function(AuthStateSignedIn value)? signedIn,
    TResult? Function(AuthStateSignedUp value)? signedUp,
  }) {
    return signedUp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateSignedOut value)? signedOut,
    TResult Function(AuthStateSignedIn value)? signedIn,
    TResult Function(AuthStateSignedUp value)? signedUp,
    required TResult orElse(),
  }) {
    if (signedUp != null) {
      return signedUp(this);
    }
    return orElse();
  }
}

abstract class AuthStateSignedUp implements AuthState {
  const factory AuthStateSignedUp(final PUser user) = _$AuthStateSignedUpImpl;

  PUser get user;
  @JsonKey(ignore: true)
  _$$AuthStateSignedUpImplCopyWith<_$AuthStateSignedUpImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
