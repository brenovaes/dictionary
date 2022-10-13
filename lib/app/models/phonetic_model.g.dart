// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phonetic_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhoneticAdapter extends TypeAdapter<Phonetic> {
  @override
  final int typeId = 2;

  @override
  Phonetic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Phonetic(
      text: fields[0] as String?,
      audio: fields[1] as String,
      sourceUrl: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Phonetic obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.audio)
      ..writeByte(2)
      ..write(obj.sourceUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhoneticAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
