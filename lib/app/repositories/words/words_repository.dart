import 'package:dictionary/app/models/response_model.dart';
import 'package:dictionary/app/models/word_model.dart';

abstract class WordsRepository {
  Future<List<WordModel>> getAllWordsFromCache();

  Future<List<WordModel>?> getAllWordsFromNetwork();

  Future<void> saveWordsToCache(List<WordModel> words);

  Future<ResponseModel?> getWordFromDictionary(WordModel item);
}
