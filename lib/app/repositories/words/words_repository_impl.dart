import 'package:dictionary/app/core/rest_client/rest_client.dart';
import 'package:dictionary/app/models/dictionary_word_model.dart';
import 'package:dictionary/app/models/response_model.dart';
import 'package:dictionary/app/models/word_model.dart';
import 'package:dictionary/app/repositories/words/words_repository.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WordsRepositoryImpl implements WordsRepository {
  final RestClient _restClient;
  final Box<WordModel> _wordsBox;

  WordsRepositoryImpl({required RestClient restClient})
      : _restClient = restClient,
        _wordsBox = Get.find();

  @override
  Future<List<WordModel>> getAllWordsFromCache() async =>
      _wordsBox.toMap().values.toList();

  @override
  Future<List<WordModel>?> getAllWordsFromNetwork() async {
    try {
      final result = await _restClient.get(
        'https://raw.githubusercontent.com/meetDeveloper/freeDictionaryAPI/master/meta/wordList/english.txt',
      );

      if (result.statusCode == 200) {
        final words = result.body.split('\n');

        final parsedWords = <WordModel>[];

        for (var word in words) {
          parsedWords.add(WordModel(word: word.toString()));
        }

        return parsedWords;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveWordsToCache(List<WordModel> words) async {
    await _wordsBox.addAll(words);
  }

  @override
  Future<ResponseModel?> getWordFromDictionary(WordModel item) async {
    try {
      final result = await _restClient.get(
        'https://api.dictionaryapi.dev/api/v2/entries/en/${item.word}',
      );

      final response = ResponseModel(
        statusCode: result.statusCode!.toInt(),
        message: result.statusText.toString(),
      );
      if (result.statusCode == 200) {
        response.body = DictionaryWordModel.fromMap(result.body.first);
      } else {
        response.body = null;
      }
      return response;
    } catch (e) {
      return null;
    }
  }
}
