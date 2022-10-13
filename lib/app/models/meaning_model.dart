import 'dart:convert';

import 'package:dictionary/app/models/definition_model.dart';
import 'package:hive/hive.dart';
part 'meaning_model.g.dart';

@HiveType(typeId: 3)
class Meaning extends HiveObject {
  @HiveField(0)
  String partOfSpeech;
  @HiveField(1)
  List<Definition> definitions;
  @HiveField(2)
  List<String> synonyms;
  @HiveField(3)
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
