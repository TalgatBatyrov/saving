// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saving.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavingAdapter extends TypeAdapter<Saving> {
  @override
  final int typeId = 1;

  @override
  Saving read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Saving(
      id: fields[0] as String,
      goal: fields[1] as String,
      remaining: fields[2] as int,
      total: fields[3] as int,
      current: fields[4] as int,
      isCompleted: fields[5] as bool,
      userId: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Saving obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.goal)
      ..writeByte(2)
      ..write(obj.remaining)
      ..writeByte(3)
      ..write(obj.total)
      ..writeByte(4)
      ..write(obj.current)
      ..writeByte(5)
      ..write(obj.isCompleted)
      ..writeByte(6)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Saving _$$_SavingFromJson(Map<String, dynamic> json) => _$_Saving(
      id: json['id'] as String,
      goal: json['goal'] as String,
      remaining: json['remaining'] as int,
      total: json['total'] as int,
      current: json['current'] as int,
      isCompleted: json['isCompleted'] as bool,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$$_SavingToJson(_$_Saving instance) => <String, dynamic>{
      'id': instance.id,
      'goal': instance.goal,
      'remaining': instance.remaining,
      'total': instance.total,
      'current': instance.current,
      'isCompleted': instance.isCompleted,
      'userId': instance.userId,
    };
