import 'package:hive/hive.dart';
part 'word_model.g.dart';

@HiveType(typeId: 0)
class Word extends HiveObject {
  @HiveField(0)
  String word;

  Word({
    required this.word,
  });

  @override
  String toString() => 'Word(word: $word)';
}
