import 'package:dictionary/app/models/dictionary_word_model.dart';
import 'package:dictionary/app/models/response_model.dart';
import 'package:dictionary/app/models/word_model.dart';

abstract class WordsRepository {
  Future<List<Word>> getWordsFromCache(String? filter, {int offset});

  Future<List<Word>?> getAllWordsFromNetwork();

  Future<void> saveWordsToCache(List<Word> words);

  Future<ResponseModel?> getWordFromDictionary(String item);

  Future<bool> saveDictionaryWordToCache(DictionaryWord item);

  Future<List<DictionaryWord>> findWord(String word, String box);

  Future<void> saveNewItemToHistory(DictionaryWord item);

  Future<void> saveNewFavorite(DictionaryWord item);

  Future<List<DictionaryWord>> getAllFromHistory();

  Future<List<DictionaryWord>> getAllFromFavorites();

  Future<void> removeFromFavorites(DictionaryWord character);
}
