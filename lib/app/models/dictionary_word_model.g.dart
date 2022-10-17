// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_word_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DictionaryWordAdapter extends TypeAdapter<DictionaryWord> {
  @override
  final int typeId = 1;

  @override
  DictionaryWord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DictionaryWord(
      word: fields[0] as String,
      phonetic: fields[1] as String?,
      phonetics: (fields[2] as List).cast<Phonetic?>(),
      meanings: (fields[3] as List).cast<Meaning>(),
      sourceUrls: (fields[4] as List).cast<String>(),
      table: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DictionaryWord obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.phonetic)
      ..writeByte(2)
      ..write(obj.phonetics)
      ..writeByte(3)
      ..write(obj.meanings)
      ..writeByte(4)
      ..write(obj.sourceUrls)
      ..writeByte(5)
      ..write(obj.table);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DictionaryWordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
