import 'dart:convert';

import 'package:hive/hive.dart';
part 'phonetic_model.g.dart';

@HiveType(typeId: 2)
class Phonetic extends HiveObject {
  @HiveField(0)
  String? text;
  @HiveField(1)
  String audio;
  @HiveField(2)
  String? sourceUrl;

  Phonetic({
    required this.text,
    required this.audio,
    required this.sourceUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'audio': audio,
      'sourceUrl': sourceUrl,
    };
  }

  factory Phonetic.fromMap(Map<String, dynamic> map) {
    return Phonetic(
      text: map['text'] != null ? map['text'] as String : null,
      audio: map['audio'] as String,
      sourceUrl: map['sourceUrl'] != null ? map['sourceUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Phonetic.fromJson(String source) =>
      Phonetic.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Phonetic(text: $text, audio: $audio, sourceUrl: $sourceUrl)';
}
