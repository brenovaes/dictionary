import 'dart:convert';

import 'package:hive/hive.dart';
part 'word_model.g.dart';

@HiveType(typeId: 0)
class WordModel extends HiveObject {
  @HiveField(0)
  String word;

  WordModel({
    required this.word,
  });

  WordModel copyWith({
    String? word,
  }) {
    return WordModel(
      word: word ?? this.word,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'word': word,
    };
  }

  /* factory WordModel.fromList(List<dynamic> list) {
    return List<WordModel>.from(
      (list).map<WordModel>((word) => WordModel(word: word))
    );
  } */

  factory WordModel.fromMap(Map<String, dynamic> map) {
    return WordModel(
      word: map['word'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WordModel.fromJson(String source) =>
      WordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WordModel(word: $word)';
}
