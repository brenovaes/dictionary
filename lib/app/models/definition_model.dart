import 'dart:convert';

import 'package:hive/hive.dart';
part 'definition_model.g.dart';

@HiveType(typeId: 4)
class Definition extends HiveObject {
  @HiveField(0)
  String definition;
  @HiveField(1)
  List<String> synonyms;
  @HiveField(2)
  List<String> antonyms;
  @HiveField(3)
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
