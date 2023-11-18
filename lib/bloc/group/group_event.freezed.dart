// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GroupEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(bool value) join,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(bool value)? join,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(bool value)? join,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GroupEventLoad value) load,
    required TResult Function(GroupEventJoin value) join,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GroupEventLoad value)? load,
    TResult? Function(GroupEventJoin value)? join,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GroupEventLoad value)? load,
    TResult Function(GroupEventJoin value)? join,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupEventCopyWith<$Res> {
  factory $GroupEventCopyWith(
          GroupEvent value, $Res Function(GroupEvent) then) =
      _$GroupEventCopyWithImpl<$Res, GroupEvent>;
}

/// @nodoc
class _$GroupEventCopyWithImpl<$Res, $Val extends GroupEvent>
    implements $GroupEventCopyWith<$Res> {
  _$GroupEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GroupEventLoadImplCopyWith<$Res> {
  factory _$$GroupEventLoadImplCopyWith(_$GroupEventLoadImpl value,
          $Res Function(_$GroupEventLoadImpl) then) =
      __$$GroupEventLoadImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GroupEventLoadImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$GroupEventLoadImpl>
    implements _$$GroupEventLoadImplCopyWith<$Res> {
  __$$GroupEventLoadImplCopyWithImpl(
      _$GroupEventLoadImpl _value, $Res Function(_$GroupEventLoadImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GroupEventLoadImpl implements GroupEventLoad {
  const _$GroupEventLoadImpl();

  @override
  String toString() {
    return 'GroupEvent.load()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GroupEventLoadImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(bool value) join,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(bool value)? join,
  }) {
    return load?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(bool value)? join,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GroupEventLoad value) load,
    required TResult Function(GroupEventJoin value) join,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GroupEventLoad value)? load,
    TResult? Function(GroupEventJoin value)? join,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GroupEventLoad value)? load,
    TResult Function(GroupEventJoin value)? join,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class GroupEventLoad implements GroupEvent {
  const factory GroupEventLoad() = _$GroupEventLoadImpl;
}

/// @nodoc
abstract class _$$GroupEventJoinImplCopyWith<$Res> {
  factory _$$GroupEventJoinImplCopyWith(_$GroupEventJoinImpl value,
          $Res Function(_$GroupEventJoinImpl) then) =
      __$$GroupEventJoinImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool value});
}

/// @nodoc
class __$$GroupEventJoinImplCopyWithImpl<$Res>
    extends _$GroupEventCopyWithImpl<$Res, _$GroupEventJoinImpl>
    implements _$$GroupEventJoinImplCopyWith<$Res> {
  __$$GroupEventJoinImplCopyWithImpl(
      _$GroupEventJoinImpl _value, $Res Function(_$GroupEventJoinImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$GroupEventJoinImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$GroupEventJoinImpl implements GroupEventJoin {
  const _$GroupEventJoinImpl(this.value);

  @override
  final bool value;

  @override
  String toString() {
    return 'GroupEvent.join(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupEventJoinImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupEventJoinImplCopyWith<_$GroupEventJoinImpl> get copyWith =>
      __$$GroupEventJoinImplCopyWithImpl<_$GroupEventJoinImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function(bool value) join,
  }) {
    return join(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? load,
    TResult? Function(bool value)? join,
  }) {
    return join?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function(bool value)? join,
    required TResult orElse(),
  }) {
    if (join != null) {
      return join(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GroupEventLoad value) load,
    required TResult Function(GroupEventJoin value) join,
  }) {
    return join(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GroupEventLoad value)? load,
    TResult? Function(GroupEventJoin value)? join,
  }) {
    return join?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GroupEventLoad value)? load,
    TResult Function(GroupEventJoin value)? join,
    required TResult orElse(),
  }) {
    if (join != null) {
      return join(this);
    }
    return orElse();
  }
}

abstract class GroupEventJoin implements GroupEvent {
  const factory GroupEventJoin(final bool value) = _$GroupEventJoinImpl;

  bool get value;
  @JsonKey(ignore: true)
  _$$GroupEventJoinImplCopyWith<_$GroupEventJoinImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
