// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Statistic _$StatisticFromJson(Map<String, dynamic> json) {
  return _Statistic.fromJson(json);
}

/// @nodoc
mixin _$Statistic {
  int get money => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get savingId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatisticCopyWith<Statistic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatisticCopyWith<$Res> {
  factory $StatisticCopyWith(Statistic value, $Res Function(Statistic) then) =
      _$StatisticCopyWithImpl<$Res, Statistic>;
  @useResult
  $Res call({int money, DateTime date, String id, String savingId});
}

/// @nodoc
class _$StatisticCopyWithImpl<$Res, $Val extends Statistic>
    implements $StatisticCopyWith<$Res> {
  _$StatisticCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? money = null,
    Object? date = null,
    Object? id = null,
    Object? savingId = null,
  }) {
    return _then(_value.copyWith(
      money: null == money
          ? _value.money
          : money // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      savingId: null == savingId
          ? _value.savingId
          : savingId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StatisticCopyWith<$Res> implements $StatisticCopyWith<$Res> {
  factory _$$_StatisticCopyWith(
          _$_Statistic value, $Res Function(_$_Statistic) then) =
      __$$_StatisticCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int money, DateTime date, String id, String savingId});
}

/// @nodoc
class __$$_StatisticCopyWithImpl<$Res>
    extends _$StatisticCopyWithImpl<$Res, _$_Statistic>
    implements _$$_StatisticCopyWith<$Res> {
  __$$_StatisticCopyWithImpl(
      _$_Statistic _value, $Res Function(_$_Statistic) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? money = null,
    Object? date = null,
    Object? id = null,
    Object? savingId = null,
  }) {
    return _then(_$_Statistic(
      money: null == money
          ? _value.money
          : money // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      savingId: null == savingId
          ? _value.savingId
          : savingId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Statistic extends _Statistic {
  const _$_Statistic(
      {required this.money,
      required this.date,
      required this.id,
      required this.savingId})
      : super._();

  factory _$_Statistic.fromJson(Map<String, dynamic> json) =>
      _$$_StatisticFromJson(json);

  @override
  final int money;
  @override
  final DateTime date;
  @override
  final String id;
  @override
  final String savingId;

  @override
  String toString() {
    return 'Statistic(money: $money, date: $date, id: $id, savingId: $savingId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Statistic &&
            (identical(other.money, money) || other.money == money) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.savingId, savingId) ||
                other.savingId == savingId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, money, date, id, savingId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StatisticCopyWith<_$_Statistic> get copyWith =>
      __$$_StatisticCopyWithImpl<_$_Statistic>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StatisticToJson(
      this,
    );
  }
}

abstract class _Statistic extends Statistic {
  const factory _Statistic(
      {required final int money,
      required final DateTime date,
      required final String id,
      required final String savingId}) = _$_Statistic;
  const _Statistic._() : super._();

  factory _Statistic.fromJson(Map<String, dynamic> json) =
      _$_Statistic.fromJson;

  @override
  int get money;
  @override
  DateTime get date;
  @override
  String get id;
  @override
  String get savingId;
  @override
  @JsonKey(ignore: true)
  _$$_StatisticCopyWith<_$_Statistic> get copyWith =>
      throw _privateConstructorUsedError;
}
