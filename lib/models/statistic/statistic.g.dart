// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Statistic _$$_StatisticFromJson(Map<String, dynamic> json) => _$_Statistic(
      money: json['money'] as int,
      date: DateTime.parse(json['date'] as String),
      id: json['id'] as String,
      savingId: json['savingId'] as String,
    );

Map<String, dynamic> _$$_StatisticToJson(_$_Statistic instance) =>
    <String, dynamic>{
      'money': instance.money,
      'date': instance.date.toIso8601String(),
      'id': instance.id,
      'savingId': instance.savingId,
    };
