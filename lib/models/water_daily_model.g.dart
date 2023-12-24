// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_daily_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WaterDailyModelAdapter extends TypeAdapter<WaterDailyModel> {
  @override
  final int typeId = 79;

  @override
  WaterDailyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WaterDailyModel()
      ..dateMl = fields[0] as String
      ..targetMl = fields[1] as int
      ..portionMl = fields[2] as int
      ..percentMl = fields[3] as int
      ..dateTime = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, WaterDailyModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.dateMl)
      ..writeByte(1)
      ..write(obj.targetMl)
      ..writeByte(2)
      ..write(obj.portionMl)
      ..writeByte(3)
      ..write(obj.percentMl)
      ..writeByte(4)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WaterDailyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
