import 'package:dictionary/app/models/definition_model.dart';
import 'package:dictionary/app/models/dictionary_word_model.dart';
import 'package:dictionary/app/models/meaning_model.dart';
import 'package:dictionary/app/models/phonetic_model.dart';
import 'package:dictionary/app/models/word_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveInitController {
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(WordAdapter());
    Hive.registerAdapter(DictionaryWordAdapter());
    Hive.registerAdapter(DefinitionAdapter());
    Hive.registerAdapter(MeaningAdapter());
    Hive.registerAdapter(PhoneticAdapter());

    Box<Word> wordsBox = await Hive.openBox<Word>('words');
    Box<DictionaryWord> favoritesBox =
        await Hive.openBox<DictionaryWord>('favorites');
    Box<DictionaryWord> historyBox =
        await Hive.openBox<DictionaryWord>('history');

    Get.put<Box<Word>>(
      wordsBox,
      permanent: true,
    );
    Get.put<Box<DictionaryWord>>(
      favoritesBox,
      permanent: true,
      tag: 'favorites',
    );
    Get.put<Box<DictionaryWord>>(
      historyBox,
      permanent: true,
      tag: 'history',
    );
  }
}
