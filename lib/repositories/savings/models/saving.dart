import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';

part 'saving.freezed.dart';
part 'saving.g.dart';

@freezed
@HiveType(typeId: 1)
class Saving with _$Saving {
  const Saving._();
  factory Saving({
    @HiveField(0) required String id,
    @HiveField(1) required String goal,
    @HiveField(2) required int remaining,
    @HiveField(3) required int total,
    @HiveField(4) required int current,
    @HiveField(5) required bool isCompleted,
    @HiveField(6) required String userId,
  }) = _Saving;

  factory Saving.fromJson(Map<String, dynamic> json) => _$SavingFromJson(json);
}
