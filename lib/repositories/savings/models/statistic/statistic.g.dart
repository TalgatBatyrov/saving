// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Statistic _$StatisticFromJson(Map<String, dynamic> json) => Statistic(
      money: json['money'] as int,
      date: DateTime.parse(json['date'] as String),
      id: json['id'] as String,
      savingId: json['savingId'] as String,
    );

Map<String, dynamic> _$StatisticToJson(Statistic instance) => <String, dynamic>{
      'money': instance.money,
      'date': instance.date.toIso8601String(),
      'id': instance.id,
      'savingId': instance.savingId,
    };
