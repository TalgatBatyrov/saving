// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistic_changes_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$StatisticChangesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() waiting,
    required TResult Function(Statistic statistic) remowed,
    required TResult Function(Statistic statistic) updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? waiting,
    TResult? Function(Statistic statistic)? remowed,
    TResult? Function(Statistic statistic)? updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? waiting,
    TResult Function(Statistic statistic)? remowed,
    TResult Function(Statistic statistic)? updated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Waiting value) waiting,
    required TResult Function(_Remowed value) remowed,
    required TResult Function(_Updated value) updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Waiting value)? waiting,
    TResult? Function(_Remowed value)? remowed,
    TResult? Function(_Updated value)? updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Waiting value)? waiting,
    TResult Function(_Remowed value)? remowed,
    TResult Function(_Updated value)? updated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatisticChangesStateCopyWith<$Res> {
  factory $StatisticChangesStateCopyWith(StatisticChangesState value,
          $Res Function(StatisticChangesState) then) =
      _$StatisticChangesStateCopyWithImpl<$Res, StatisticChangesState>;
}

/// @nodoc
class _$StatisticChangesStateCopyWithImpl<$Res,
        $Val extends StatisticChangesState>
    implements $StatisticChangesStateCopyWith<$Res> {
  _$StatisticChangesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_WaitingCopyWith<$Res> {
  factory _$$_WaitingCopyWith(
          _$_Waiting value, $Res Function(_$_Waiting) then) =
      __$$_WaitingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_WaitingCopyWithImpl<$Res>
    extends _$StatisticChangesStateCopyWithImpl<$Res, _$_Waiting>
    implements _$$_WaitingCopyWith<$Res> {
  __$$_WaitingCopyWithImpl(_$_Waiting _value, $Res Function(_$_Waiting) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Waiting implements _Waiting {
  const _$_Waiting();

  @override
  String toString() {
    return 'StatisticChangesState.waiting()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Waiting);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() waiting,
    required TResult Function(Statistic statistic) remowed,
    required TResult Function(Statistic statistic) updated,
  }) {
    return waiting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? waiting,
    TResult? Function(Statistic statistic)? remowed,
    TResult? Function(Statistic statistic)? updated,
  }) {
    return waiting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? waiting,
    TResult Function(Statistic statistic)? remowed,
    TResult Function(Statistic statistic)? updated,
    required TResult orElse(),
  }) {
    if (waiting != null) {
      return waiting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Waiting value) waiting,
    required TResult Function(_Remowed value) remowed,
    required TResult Function(_Updated value) updated,
  }) {
    return waiting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Waiting value)? waiting,
    TResult? Function(_Remowed value)? remowed,
    TResult? Function(_Updated value)? updated,
  }) {
    return waiting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Waiting value)? waiting,
    TResult Function(_Remowed value)? remowed,
    TResult Function(_Updated value)? updated,
    required TResult orElse(),
  }) {
    if (waiting != null) {
      return waiting(this);
    }
    return orElse();
  }
}

abstract class _Waiting implements StatisticChangesState {
  const factory _Waiting() = _$_Waiting;
}

/// @nodoc
abstract class _$$_RemowedCopyWith<$Res> {
  factory _$$_RemowedCopyWith(
          _$_Remowed value, $Res Function(_$_Remowed) then) =
      __$$_RemowedCopyWithImpl<$Res>;
  @useResult
  $Res call({Statistic statistic});

  $StatisticCopyWith<$Res> get statistic;
}

/// @nodoc
class __$$_RemowedCopyWithImpl<$Res>
    extends _$StatisticChangesStateCopyWithImpl<$Res, _$_Remowed>
    implements _$$_RemowedCopyWith<$Res> {
  __$$_RemowedCopyWithImpl(_$_Remowed _value, $Res Function(_$_Remowed) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statistic = null,
  }) {
    return _then(_$_Remowed(
      null == statistic
          ? _value.statistic
          : statistic // ignore: cast_nullable_to_non_nullable
              as Statistic,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $StatisticCopyWith<$Res> get statistic {
    return $StatisticCopyWith<$Res>(_value.statistic, (value) {
      return _then(_value.copyWith(statistic: value));
    });
  }
}

/// @nodoc

class _$_Remowed implements _Remowed {
  const _$_Remowed(this.statistic);

  @override
  final Statistic statistic;

  @override
  String toString() {
    return 'StatisticChangesState.remowed(statistic: $statistic)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Remowed &&
            (identical(other.statistic, statistic) ||
                other.statistic == statistic));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statistic);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RemowedCopyWith<_$_Remowed> get copyWith =>
      __$$_RemowedCopyWithImpl<_$_Remowed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() waiting,
    required TResult Function(Statistic statistic) remowed,
    required TResult Function(Statistic statistic) updated,
  }) {
    return remowed(statistic);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? waiting,
    TResult? Function(Statistic statistic)? remowed,
    TResult? Function(Statistic statistic)? updated,
  }) {
    return remowed?.call(statistic);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? waiting,
    TResult Function(Statistic statistic)? remowed,
    TResult Function(Statistic statistic)? updated,
    required TResult orElse(),
  }) {
    if (remowed != null) {
      return remowed(statistic);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Waiting value) waiting,
    required TResult Function(_Remowed value) remowed,
    required TResult Function(_Updated value) updated,
  }) {
    return remowed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Waiting value)? waiting,
    TResult? Function(_Remowed value)? remowed,
    TResult? Function(_Updated value)? updated,
  }) {
    return remowed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Waiting value)? waiting,
    TResult Function(_Remowed value)? remowed,
    TResult Function(_Updated value)? updated,
    required TResult orElse(),
  }) {
    if (remowed != null) {
      return remowed(this);
    }
    return orElse();
  }
}

abstract class _Remowed implements StatisticChangesState {
  const factory _Remowed(final Statistic statistic) = _$_Remowed;

  Statistic get statistic;
  @JsonKey(ignore: true)
  _$$_RemowedCopyWith<_$_Remowed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_UpdatedCopyWith<$Res> {
  factory _$$_UpdatedCopyWith(
          _$_Updated value, $Res Function(_$_Updated) then) =
      __$$_UpdatedCopyWithImpl<$Res>;
  @useResult
  $Res call({Statistic statistic});

  $StatisticCopyWith<$Res> get statistic;
}

/// @nodoc
class __$$_UpdatedCopyWithImpl<$Res>
    extends _$StatisticChangesStateCopyWithImpl<$Res, _$_Updated>
    implements _$$_UpdatedCopyWith<$Res> {
  __$$_UpdatedCopyWithImpl(_$_Updated _value, $Res Function(_$_Updated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statistic = null,
  }) {
    return _then(_$_Updated(
      null == statistic
          ? _value.statistic
          : statistic // ignore: cast_nullable_to_non_nullable
              as Statistic,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $StatisticCopyWith<$Res> get statistic {
    return $StatisticCopyWith<$Res>(_value.statistic, (value) {
      return _then(_value.copyWith(statistic: value));
    });
  }
}

/// @nodoc

class _$_Updated implements _Updated {
  const _$_Updated(this.statistic);

  @override
  final Statistic statistic;

  @override
  String toString() {
    return 'StatisticChangesState.updated(statistic: $statistic)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Updated &&
            (identical(other.statistic, statistic) ||
                other.statistic == statistic));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statistic);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UpdatedCopyWith<_$_Updated> get copyWith =>
      __$$_UpdatedCopyWithImpl<_$_Updated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() waiting,
    required TResult Function(Statistic statistic) remowed,
    required TResult Function(Statistic statistic) updated,
  }) {
    return updated(statistic);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? waiting,
    TResult? Function(Statistic statistic)? remowed,
    TResult? Function(Statistic statistic)? updated,
  }) {
    return updated?.call(statistic);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? waiting,
    TResult Function(Statistic statistic)? remowed,
    TResult Function(Statistic statistic)? updated,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(statistic);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Waiting value) waiting,
    required TResult Function(_Remowed value) remowed,
    required TResult Function(_Updated value) updated,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Waiting value)? waiting,
    TResult? Function(_Remowed value)? remowed,
    TResult? Function(_Updated value)? updated,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Waiting value)? waiting,
    TResult Function(_Remowed value)? remowed,
    TResult Function(_Updated value)? updated,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class _Updated implements StatisticChangesState {
  const factory _Updated(final Statistic statistic) = _$_Updated;

  Statistic get statistic;
  @JsonKey(ignore: true)
  _$$_UpdatedCopyWith<_$_Updated> get copyWith =>
      throw _privateConstructorUsedError;
}
