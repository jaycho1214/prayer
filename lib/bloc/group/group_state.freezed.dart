// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GroupState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(Group group, String? message) loaded,
    required TResult Function(Group group) refreshing,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(Group group, String? message)? loaded,
    TResult? Function(Group group)? refreshing,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(Group group, String? message)? loaded,
    TResult Function(Group group)? refreshing,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GroupStateIdle value) idle,
    required TResult Function(GroupStateLoading value) loading,
    required TResult Function(GroupStateLoaded value) loaded,
    required TResult Function(GroupStateRefreshing value) refreshing,
    required TResult Function(GroupStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GroupStateIdle value)? idle,
    TResult? Function(GroupStateLoading value)? loading,
    TResult? Function(GroupStateLoaded value)? loaded,
    TResult? Function(GroupStateRefreshing value)? refreshing,
    TResult? Function(GroupStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GroupStateIdle value)? idle,
    TResult Function(GroupStateLoading value)? loading,
    TResult Function(GroupStateLoaded value)? loaded,
    TResult Function(GroupStateRefreshing value)? refreshing,
    TResult Function(GroupStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupStateCopyWith<$Res> {
  factory $GroupStateCopyWith(
          GroupState value, $Res Function(GroupState) then) =
      _$GroupStateCopyWithImpl<$Res, GroupState>;
}

/// @nodoc
class _$GroupStateCopyWithImpl<$Res, $Val extends GroupState>
    implements $GroupStateCopyWith<$Res> {
  _$GroupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GroupStateIdleImplCopyWith<$Res> {
  factory _$$GroupStateIdleImplCopyWith(_$GroupStateIdleImpl value,
          $Res Function(_$GroupStateIdleImpl) then) =
      __$$GroupStateIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GroupStateIdleImplCopyWithImpl<$Res>
    extends _$GroupStateCopyWithImpl<$Res, _$GroupStateIdleImpl>
    implements _$$GroupStateIdleImplCopyWith<$Res> {
  __$$GroupStateIdleImplCopyWithImpl(
      _$GroupStateIdleImpl _value, $Res Function(_$GroupStateIdleImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GroupStateIdleImpl implements GroupStateIdle {
  const _$GroupStateIdleImpl();

  @override
  String toString() {
    return 'GroupState.idle()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GroupStateIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(Group group, String? message) loaded,
    required TResult Function(Group group) refreshing,
    required TResult Function(String message) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(Group group, String? message)? loaded,
    TResult? Function(Group group)? refreshing,
    TResult? Function(String message)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(Group group, String? message)? loaded,
    TResult Function(Group group)? refreshing,
    TResult Function(String message)? error,
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
    required TResult Function(GroupStateIdle value) idle,
    required TResult Function(GroupStateLoading value) loading,
    required TResult Function(GroupStateLoaded value) loaded,
    required TResult Function(GroupStateRefreshing value) refreshing,
    required TResult Function(GroupStateError value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GroupStateIdle value)? idle,
    TResult? Function(GroupStateLoading value)? loading,
    TResult? Function(GroupStateLoaded value)? loaded,
    TResult? Function(GroupStateRefreshing value)? refreshing,
    TResult? Function(GroupStateError value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GroupStateIdle value)? idle,
    TResult Function(GroupStateLoading value)? loading,
    TResult Function(GroupStateLoaded value)? loaded,
    TResult Function(GroupStateRefreshing value)? refreshing,
    TResult Function(GroupStateError value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class GroupStateIdle implements GroupState {
  const factory GroupStateIdle() = _$GroupStateIdleImpl;
}

/// @nodoc
abstract class _$$GroupStateLoadingImplCopyWith<$Res> {
  factory _$$GroupStateLoadingImplCopyWith(_$GroupStateLoadingImpl value,
          $Res Function(_$GroupStateLoadingImpl) then) =
      __$$GroupStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GroupStateLoadingImplCopyWithImpl<$Res>
    extends _$GroupStateCopyWithImpl<$Res, _$GroupStateLoadingImpl>
    implements _$$GroupStateLoadingImplCopyWith<$Res> {
  __$$GroupStateLoadingImplCopyWithImpl(_$GroupStateLoadingImpl _value,
      $Res Function(_$GroupStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GroupStateLoadingImpl implements GroupStateLoading {
  const _$GroupStateLoadingImpl();

  @override
  String toString() {
    return 'GroupState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GroupStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(Group group, String? message) loaded,
    required TResult Function(Group group) refreshing,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(Group group, String? message)? loaded,
    TResult? Function(Group group)? refreshing,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(Group group, String? message)? loaded,
    TResult Function(Group group)? refreshing,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GroupStateIdle value) idle,
    required TResult Function(GroupStateLoading value) loading,
    required TResult Function(GroupStateLoaded value) loaded,
    required TResult Function(GroupStateRefreshing value) refreshing,
    required TResult Function(GroupStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GroupStateIdle value)? idle,
    TResult? Function(GroupStateLoading value)? loading,
    TResult? Function(GroupStateLoaded value)? loaded,
    TResult? Function(GroupStateRefreshing value)? refreshing,
    TResult? Function(GroupStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GroupStateIdle value)? idle,
    TResult Function(GroupStateLoading value)? loading,
    TResult Function(GroupStateLoaded value)? loaded,
    TResult Function(GroupStateRefreshing value)? refreshing,
    TResult Function(GroupStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class GroupStateLoading implements GroupState {
  const factory GroupStateLoading() = _$GroupStateLoadingImpl;
}

/// @nodoc
abstract class _$$GroupStateLoadedImplCopyWith<$Res> {
  factory _$$GroupStateLoadedImplCopyWith(_$GroupStateLoadedImpl value,
          $Res Function(_$GroupStateLoadedImpl) then) =
      __$$GroupStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Group group, String? message});

  $GroupCopyWith<$Res> get group;
}

/// @nodoc
class __$$GroupStateLoadedImplCopyWithImpl<$Res>
    extends _$GroupStateCopyWithImpl<$Res, _$GroupStateLoadedImpl>
    implements _$$GroupStateLoadedImplCopyWith<$Res> {
  __$$GroupStateLoadedImplCopyWithImpl(_$GroupStateLoadedImpl _value,
      $Res Function(_$GroupStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = null,
    Object? message = freezed,
  }) {
    return _then(_$GroupStateLoadedImpl(
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $GroupCopyWith<$Res> get group {
    return $GroupCopyWith<$Res>(_value.group, (value) {
      return _then(_value.copyWith(group: value));
    });
  }
}

/// @nodoc

class _$GroupStateLoadedImpl implements GroupStateLoaded {
  const _$GroupStateLoadedImpl({required this.group, this.message});

  @override
  final Group group;
  @override
  final String? message;

  @override
  String toString() {
    return 'GroupState.loaded(group: $group, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupStateLoadedImpl &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, group, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupStateLoadedImplCopyWith<_$GroupStateLoadedImpl> get copyWith =>
      __$$GroupStateLoadedImplCopyWithImpl<_$GroupStateLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(Group group, String? message) loaded,
    required TResult Function(Group group) refreshing,
    required TResult Function(String message) error,
  }) {
    return loaded(group, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(Group group, String? message)? loaded,
    TResult? Function(Group group)? refreshing,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(group, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(Group group, String? message)? loaded,
    TResult Function(Group group)? refreshing,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(group, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GroupStateIdle value) idle,
    required TResult Function(GroupStateLoading value) loading,
    required TResult Function(GroupStateLoaded value) loaded,
    required TResult Function(GroupStateRefreshing value) refreshing,
    required TResult Function(GroupStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GroupStateIdle value)? idle,
    TResult? Function(GroupStateLoading value)? loading,
    TResult? Function(GroupStateLoaded value)? loaded,
    TResult? Function(GroupStateRefreshing value)? refreshing,
    TResult? Function(GroupStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GroupStateIdle value)? idle,
    TResult Function(GroupStateLoading value)? loading,
    TResult Function(GroupStateLoaded value)? loaded,
    TResult Function(GroupStateRefreshing value)? refreshing,
    TResult Function(GroupStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class GroupStateLoaded implements GroupState {
  const factory GroupStateLoaded(
      {required final Group group,
      final String? message}) = _$GroupStateLoadedImpl;

  Group get group;
  String? get message;
  @JsonKey(ignore: true)
  _$$GroupStateLoadedImplCopyWith<_$GroupStateLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GroupStateRefreshingImplCopyWith<$Res> {
  factory _$$GroupStateRefreshingImplCopyWith(_$GroupStateRefreshingImpl value,
          $Res Function(_$GroupStateRefreshingImpl) then) =
      __$$GroupStateRefreshingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Group group});

  $GroupCopyWith<$Res> get group;
}

/// @nodoc
class __$$GroupStateRefreshingImplCopyWithImpl<$Res>
    extends _$GroupStateCopyWithImpl<$Res, _$GroupStateRefreshingImpl>
    implements _$$GroupStateRefreshingImplCopyWith<$Res> {
  __$$GroupStateRefreshingImplCopyWithImpl(_$GroupStateRefreshingImpl _value,
      $Res Function(_$GroupStateRefreshingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = null,
  }) {
    return _then(_$GroupStateRefreshingImpl(
      null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $GroupCopyWith<$Res> get group {
    return $GroupCopyWith<$Res>(_value.group, (value) {
      return _then(_value.copyWith(group: value));
    });
  }
}

/// @nodoc

class _$GroupStateRefreshingImpl implements GroupStateRefreshing {
  const _$GroupStateRefreshingImpl(this.group);

  @override
  final Group group;

  @override
  String toString() {
    return 'GroupState.refreshing(group: $group)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupStateRefreshingImpl &&
            (identical(other.group, group) || other.group == group));
  }

  @override
  int get hashCode => Object.hash(runtimeType, group);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupStateRefreshingImplCopyWith<_$GroupStateRefreshingImpl>
      get copyWith =>
          __$$GroupStateRefreshingImplCopyWithImpl<_$GroupStateRefreshingImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(Group group, String? message) loaded,
    required TResult Function(Group group) refreshing,
    required TResult Function(String message) error,
  }) {
    return refreshing(group);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(Group group, String? message)? loaded,
    TResult? Function(Group group)? refreshing,
    TResult? Function(String message)? error,
  }) {
    return refreshing?.call(group);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(Group group, String? message)? loaded,
    TResult Function(Group group)? refreshing,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (refreshing != null) {
      return refreshing(group);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GroupStateIdle value) idle,
    required TResult Function(GroupStateLoading value) loading,
    required TResult Function(GroupStateLoaded value) loaded,
    required TResult Function(GroupStateRefreshing value) refreshing,
    required TResult Function(GroupStateError value) error,
  }) {
    return refreshing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GroupStateIdle value)? idle,
    TResult? Function(GroupStateLoading value)? loading,
    TResult? Function(GroupStateLoaded value)? loaded,
    TResult? Function(GroupStateRefreshing value)? refreshing,
    TResult? Function(GroupStateError value)? error,
  }) {
    return refreshing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GroupStateIdle value)? idle,
    TResult Function(GroupStateLoading value)? loading,
    TResult Function(GroupStateLoaded value)? loaded,
    TResult Function(GroupStateRefreshing value)? refreshing,
    TResult Function(GroupStateError value)? error,
    required TResult orElse(),
  }) {
    if (refreshing != null) {
      return refreshing(this);
    }
    return orElse();
  }
}

abstract class GroupStateRefreshing implements GroupState {
  const factory GroupStateRefreshing(final Group group) =
      _$GroupStateRefreshingImpl;

  Group get group;
  @JsonKey(ignore: true)
  _$$GroupStateRefreshingImplCopyWith<_$GroupStateRefreshingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GroupStateErrorImplCopyWith<$Res> {
  factory _$$GroupStateErrorImplCopyWith(_$GroupStateErrorImpl value,
          $Res Function(_$GroupStateErrorImpl) then) =
      __$$GroupStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$GroupStateErrorImplCopyWithImpl<$Res>
    extends _$GroupStateCopyWithImpl<$Res, _$GroupStateErrorImpl>
    implements _$$GroupStateErrorImplCopyWith<$Res> {
  __$$GroupStateErrorImplCopyWithImpl(
      _$GroupStateErrorImpl _value, $Res Function(_$GroupStateErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$GroupStateErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GroupStateErrorImpl implements GroupStateError {
  const _$GroupStateErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'GroupState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupStateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupStateErrorImplCopyWith<_$GroupStateErrorImpl> get copyWith =>
      __$$GroupStateErrorImplCopyWithImpl<_$GroupStateErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(Group group, String? message) loaded,
    required TResult Function(Group group) refreshing,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function(Group group, String? message)? loaded,
    TResult? Function(Group group)? refreshing,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(Group group, String? message)? loaded,
    TResult Function(Group group)? refreshing,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GroupStateIdle value) idle,
    required TResult Function(GroupStateLoading value) loading,
    required TResult Function(GroupStateLoaded value) loaded,
    required TResult Function(GroupStateRefreshing value) refreshing,
    required TResult Function(GroupStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GroupStateIdle value)? idle,
    TResult? Function(GroupStateLoading value)? loading,
    TResult? Function(GroupStateLoaded value)? loaded,
    TResult? Function(GroupStateRefreshing value)? refreshing,
    TResult? Function(GroupStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GroupStateIdle value)? idle,
    TResult Function(GroupStateLoading value)? loading,
    TResult Function(GroupStateLoaded value)? loaded,
    TResult Function(GroupStateRefreshing value)? refreshing,
    TResult Function(GroupStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class GroupStateError implements GroupState {
  const factory GroupStateError(final String message) = _$GroupStateErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$GroupStateErrorImplCopyWith<_$GroupStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
