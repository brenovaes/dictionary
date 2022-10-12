import 'package:hive/hive.dart';
part 'word_model.g.dart';

@HiveType(typeId: 0)
class WordModel extends HiveObject {
  @HiveField(0)
  String word;

  WordModel({
    required this.word,
  });

  @override
  String toString() => 'WordModel(word: $word)';
}
