import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'statistic.g.dart';

@JsonSerializable()
class Statistic extends Equatable {
  @JsonKey()
  final int money;

  @JsonKey()
  final DateTime date;

  @JsonKey()
  final String id;

  @JsonKey()
  final String savingId;

  const Statistic({
    required this.money,
    required this.date,
    required this.id,
    required this.savingId,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) =>
      _$StatisticFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticToJson(this);

  @override
  List<Object?> get props => [
        money,
        date,
        savingId,
      ];

  Statistic copyWith({
    int? money,
    DateTime? date,
    String? id,
    String? savingId,
  }) {
    return Statistic(
      money: money ?? this.money,
      date: date ?? this.date,
      id: id ?? this.id,
      savingId: savingId ?? this.savingId,
    );
  }
}
