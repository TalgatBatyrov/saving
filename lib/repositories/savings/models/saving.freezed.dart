// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saving.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Saving _$SavingFromJson(Map<String, dynamic> json) {
  return _Saving.fromJson(json);
}

/// @nodoc
mixin _$Saving {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get goal => throw _privateConstructorUsedError;
  @HiveField(2)
  int get total => throw _privateConstructorUsedError;
  @HiveField(3)
  int get current => throw _privateConstructorUsedError;
  @HiveField(4)
  String get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SavingCopyWith<Saving> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavingCopyWith<$Res> {
  factory $SavingCopyWith(Saving value, $Res Function(Saving) then) =
      _$SavingCopyWithImpl<$Res, Saving>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String goal,
      @HiveField(2) int total,
      @HiveField(3) int current,
      @HiveField(4) String userId});
}

/// @nodoc
class _$SavingCopyWithImpl<$Res, $Val extends Saving>
    implements $SavingCopyWith<$Res> {
  _$SavingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? goal = null,
    Object? total = null,
    Object? current = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      goal: null == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SavingCopyWith<$Res> implements $SavingCopyWith<$Res> {
  factory _$$_SavingCopyWith(_$_Saving value, $Res Function(_$_Saving) then) =
      __$$_SavingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String goal,
      @HiveField(2) int total,
      @HiveField(3) int current,
      @HiveField(4) String userId});
}

/// @nodoc
class __$$_SavingCopyWithImpl<$Res>
    extends _$SavingCopyWithImpl<$Res, _$_Saving>
    implements _$$_SavingCopyWith<$Res> {
  __$$_SavingCopyWithImpl(_$_Saving _value, $Res Function(_$_Saving) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? goal = null,
    Object? total = null,
    Object? current = null,
    Object? userId = null,
  }) {
    return _then(_$_Saving(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      goal: null == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Saving extends _Saving {
  _$_Saving(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.goal,
      @HiveField(2) required this.total,
      @HiveField(3) required this.current,
      @HiveField(4) required this.userId})
      : super._();

  factory _$_Saving.fromJson(Map<String, dynamic> json) =>
      _$$_SavingFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String goal;
  @override
  @HiveField(2)
  final int total;
  @override
  @HiveField(3)
  final int current;
  @override
  @HiveField(4)
  final String userId;

  @override
  String toString() {
    return 'Saving(id: $id, goal: $goal, total: $total, current: $current, userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Saving &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, goal, total, current, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SavingCopyWith<_$_Saving> get copyWith =>
      __$$_SavingCopyWithImpl<_$_Saving>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SavingToJson(
      this,
    );
  }
}

abstract class _Saving extends Saving {
  factory _Saving(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String goal,
      @HiveField(2) required final int total,
      @HiveField(3) required final int current,
      @HiveField(4) required final String userId}) = _$_Saving;
  _Saving._() : super._();

  factory _Saving.fromJson(Map<String, dynamic> json) = _$_Saving.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get goal;
  @override
  @HiveField(2)
  int get total;
  @override
  @HiveField(3)
  int get current;
  @override
  @HiveField(4)
  String get userId;
  @override
  @JsonKey(ignore: true)
  _$$_SavingCopyWith<_$_Saving> get copyWith =>
      throw _privateConstructorUsedError;
}
