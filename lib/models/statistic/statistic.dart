import 'package:freezed_annotation/freezed_annotation.dart';

part 'statistic.freezed.dart';
part 'statistic.g.dart';

@freezed
class Statistic with _$Statistic {
  const Statistic._();
  const factory Statistic({
    required int money,
    required DateTime date,
    required String id,
    required String savingId,
  }) = _Statistic;

  factory Statistic.fromJson(Map<String, dynamic> json) =>
      _$StatisticFromJson(json);
}
