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
      total: fields[2] as int,
      current: fields[3] as int,
      userId: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Saving obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.goal)
      ..writeByte(2)
      ..write(obj.total)
      ..writeByte(3)
      ..write(obj.current)
      ..writeByte(4)
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
      total: json['total'] as int,
      current: json['current'] as int,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$$_SavingToJson(_$_Saving instance) => <String, dynamic>{
      'id': instance.id,
      'goal': instance.goal,
      'total': instance.total,
      'current': instance.current,
      'userId': instance.userId,
    };
