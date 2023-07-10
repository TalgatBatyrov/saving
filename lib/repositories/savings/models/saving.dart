import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part 'saving.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Saving extends Equatable {
  @HiveField(0)
  @JsonKey()
  final String id;

  @HiveField(1)
  @JsonKey()
  final String goal;

  @HiveField(2)
  @JsonKey()
  final int remaining;

  @HiveField(3)
  @JsonKey()
  final int total;

  @HiveField(4)
  @JsonKey()
  final int current;

  @HiveField(5)
  @JsonKey()
  final bool isCompleted;

  const Saving({
    required this.id,
    required this.goal,
    required this.remaining,
    required this.total,
    required this.current,
    required this.isCompleted,
  });

  factory Saving.fromJson(Map<String, dynamic> json) => _$SavingFromJson(json);

  Map<String, dynamic> toJson() => _$SavingToJson(this);

  @override
  List<Object?> get props => [
        id,
        goal,
        remaining,
        total,
        current,
        isCompleted,
      ];

  // copy with

  Saving copyWith({
    String? id,
    String? goal,
    int? remaining,
    int? total,
    int? current,
    bool? isCompleted,
  }) {
    return Saving(
      id: id ?? this.id,
      goal: goal ?? this.goal,
      remaining: remaining ?? this.remaining,
      total: total ?? this.total,
      current: current ?? this.current,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
