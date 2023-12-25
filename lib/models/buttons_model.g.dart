// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buttons_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ButtonsModelAdapter extends TypeAdapter<ButtonsModel> {
  @override
  final int typeId = 89;

  @override
  ButtonsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ButtonsModel()..buttons = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, ButtonsModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.buttons);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ButtonsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
