import 'package:dictionary/app/models/dictionary_word_model.dart';
import 'package:dictionary/app/models/response_model.dart';
import 'package:dictionary/app/models/word_model.dart';

abstract class WordsRepository {
  Future<List<Word>> getWordsFromCache(String? filter, {int offset});

  Future<List<Word>?> getAllWordsFromNetwork();

  Future<void> saveWordsToCache(List<Word> words);

  Future<ResponseModel?> getWordFromDictionary(String item);

  Future<ResponseModel?> saveWordToRemoteDatabase(
      DictionaryWord item, String type, String jwt);

  Future<ResponseModel?> removeWordFromRemoteDatabase(
      DictionaryWord item, String type, String jwt);

  //Future<bool> saveDictionaryWordToCache(DictionaryWord item);

  Future<List<DictionaryWord>> findWord(String word, String box);

  Future<void> saveNewItemToHistory(DictionaryWord item, String? jwt);

  Future<void> saveNewFavorite(DictionaryWord item, String? jwt);

  Future<List<DictionaryWord>> getAllFromHistory();

  Future<List<DictionaryWord>> getAllFromFavorites();

  Future<void> removeFromFavorites(DictionaryWord character, String jwt);

  Future<ResponseModel?> restoreWordsFromRemoteDatabase(String jwt);

  Future<void> saveRestoredWordsToCache(List<DictionaryWord> list);
}
