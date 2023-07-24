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
    @HiveField(2) required int total,
    @HiveField(3) required int current,
    @HiveField(4) required String userId,
  }) = _Saving;

  get percent => (current / total) * 100;

  bool get isCompleted => current >= total;

  int get remainder => current >= total ? 0 : total - current;

  factory Saving.fromJson(Map<String, dynamic> json) => _$SavingFromJson(json);
}
