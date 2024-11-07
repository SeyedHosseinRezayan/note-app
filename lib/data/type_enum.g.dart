// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypeEnumAdapter extends TypeAdapter<TypeEnum> {
  @override
  final int typeId = 6;

  @override
  TypeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TypeEnum.working;
      case 1:
        return TypeEnum.focus;
      case 2:
        return TypeEnum.date;
      default:
        return TypeEnum.working;
    }
  }

  @override
  void write(BinaryWriter writer, TypeEnum obj) {
    switch (obj) {
      case TypeEnum.working:
        writer.writeByte(0);
        break;
      case TypeEnum.focus:
        writer.writeByte(1);
        break;
      case TypeEnum.date:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
