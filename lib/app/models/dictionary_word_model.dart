// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'dictionary_word_model.g.dart';

@HiveType(typeId: 1)
class DictionaryWordModel extends HiveObject {
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

  DictionaryWordModel({
    required this.word,
    required this.phonetic,
    required this.phonetics,
    required this.meanings,
    required this.sourceUrls,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'word': word,
      'phonetic': phonetic,
      'phonetics': phonetics.map((x) => x?.toMap()).toList(),
      'meanings': meanings.map((x) => x.toMap()).toList(),
      'sourceUrls': sourceUrls,
    };
  }

  factory DictionaryWordModel.fromMap(Map<String, dynamic> map) {
    return DictionaryWordModel(
      word: map['word'] as String,
      phonetic: map['phonetic'] != null ? map['phonetic'] as String : null,
      phonetics: List<Phonetic?>.from(
        (map['phonetics'] as List).map<Phonetic?>(
          (x) => Phonetic.fromMap(x as Map<String, dynamic>),
        ),
      ),
      meanings: List<Meaning>.from(
        (map['meanings'] as List).map<Meaning>(
          (x) => Meaning.fromMap(x as Map<String, dynamic>),
        ),
      ),
      sourceUrls: List<String>.from((map['sourceUrls'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory DictionaryWordModel.fromJson(String source) =>
      DictionaryWordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DictionaryWordModel(word: $word, phonetic: $phonetic, phonetics: $phonetics, meanings: $meanings, sourceUrls: $sourceUrls)';
  }
}

class Phonetic {
  String? text;
  String audio;
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

class Meaning {
  String partOfSpeech;
  List<Definition> definitions;
  List<String> synonyms;
  List<String> antonyms;

  Meaning({
    required this.partOfSpeech,
    required this.definitions,
    required this.synonyms,
    required this.antonyms,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'partOfSpeech': partOfSpeech,
      'definitions': definitions.map((x) => x.toMap()).toList(),
      'synonyms': synonyms,
      'antonyms': antonyms,
    };
  }

  factory Meaning.fromMap(Map<String, dynamic> map) {
    return Meaning(
      partOfSpeech: map['partOfSpeech'] as String,
      definitions: List<Definition>.from(
        (map['definitions'] as List).map<Definition>(
          (x) => Definition.fromMap(x as Map<String, dynamic>),
        ),
      ),
      synonyms: List<String>.from((map['synonyms'] as List)),
      antonyms: List<String>.from((map['antonyms'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Meaning.fromJson(String source) =>
      Meaning.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Meaning(partOfSpeech: $partOfSpeech, definitions: $definitions, synonyms: $synonyms, antonyms: $antonyms)';
  }
}

class Definition {
  String definition;
  List<String> synonyms;
  List<String> antonyms;
  String? example;

  Definition({
    required this.definition,
    required this.synonyms,
    required this.antonyms,
    required this.example,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'definition': definition,
      'synonyms': synonyms,
      'antonyms': antonyms,
      'example': example,
    };
  }

  factory Definition.fromMap(Map<String, dynamic> map) {
    return Definition(
      definition: map['definition'] as String,
      synonyms: List<String>.from((map['synonyms'] as List)),
      antonyms: List<String>.from((map['antonyms'] as List)),
      example: map['example'] != null ? map['example'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Definition.fromJson(String source) =>
      Definition.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Definition(definition: $definition, synonyms: $synonyms, antonyms: $antonyms, example: $example)';
  }
}
