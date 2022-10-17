import 'dart:convert';

import 'package:dictionary/app/models/meaning_model.dart';
import 'package:dictionary/app/models/phonetic_model.dart';
import 'package:hive/hive.dart';

part 'dictionary_word_model.g.dart';

@HiveType(typeId: 1)
class DictionaryWord extends HiveObject {
  @HiveField(0)
  String word;
  @HiveField(1)
  String? phonetic;
  @HiveField(2)
  List<Phonetic?> phonetics;
  @HiveField(3)
  List<Meaning> meanings;
  @HiveField(4)
  List<String> sourceUrls;
  @HiveField(5)
  bool needsLoad;
  @HiveField(6)
  String? table;

  DictionaryWord({
    required this.word,
    required this.phonetic,
    required this.phonetics,
    required this.meanings,
    required this.sourceUrls,
    this.needsLoad = false,
    this.table,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'word': word,
      'phonetic': phonetic,
      'phonetics': phonetics.map((x) => x?.toMap()).toList(),
      'meanings': meanings.map((x) => x.toMap()).toList(),
      /* 'sourceUrls': sourceUrls, */
    };
  }

  factory DictionaryWord.fromMap(Map<String, dynamic> map) {
    return DictionaryWord(
      word: map['word'] as String,
      phonetic: map['phonetic'] != null ? map['phonetic'] as String : null,
      phonetics: map['phonetics'] != null
          ? List<Phonetic?>.from(
              (map['phonetics'] as List).map<Phonetic?>(
                (x) => Phonetic.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      meanings: map['meanings'] != null
          ? List<Meaning>.from(
              (map['meanings'] as List).map<Meaning>(
                (x) => Meaning.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      sourceUrls: map['sourceUrls'] != null
          ? List<String>.from((map['sourceUrls'] as List))
          : [],
      table: map['table'] != null ? map['table'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DictionaryWord.fromJson(String source) =>
      DictionaryWord.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DictionaryWord(word: $word, phonetic: $phonetic, phonetics: $phonetics, meanings: $meanings, sourceUrls: $sourceUrls, needsLoad: $needsLoad, table: $table)';
  }
}
