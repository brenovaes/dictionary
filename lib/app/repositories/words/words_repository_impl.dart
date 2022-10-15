import 'package:dictionary/app/core/rest_client/rest_client.dart';
import 'package:dictionary/app/models/dictionary_word_model.dart';
import 'package:dictionary/app/models/response_model.dart';
import 'package:dictionary/app/models/word_model.dart';
import 'package:dictionary/app/repositories/words/words_repository.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WordsRepositoryImpl implements WordsRepository {
  final RestClient _restClient;
  final Box<Word> _wordsBox;
  final Box<DictionaryWord> _favoritesBox;
  final Box<DictionaryWord> _historyBox;

  WordsRepositoryImpl({required RestClient restClient})
      : _restClient = restClient,
        _favoritesBox = Get.find(tag: 'favorites'),
        _historyBox = Get.find(tag: 'history'),
        _wordsBox = Get.find();

  @override
  Future<List<Word>> getWordsFromCache(String? filter, {int offset = 0}) async {
    List<Word> resultList;

    switch (filter) {
      case '':
        resultList = _wordsBox
            .valuesBetween(startKey: offset, endKey: offset + 29)
            .toList();
        break;
      default:
        resultList = _wordsBox
            .toMap()
            .values
            /* .valuesBetween(startKey: offset, endKey: offset + 29) */
            .where((value) => value.word.startsWith(filter.toString()))
            .toList();
        break;
    }
    return resultList;
  }

  @override
  Future<List<Word>?> getAllWordsFromNetwork() async {
    try {
      final result = await _restClient.get(
        'https://raw.githubusercontent.com/meetDeveloper/freeDictionaryAPI/master/meta/wordList/english.txt',
      );

      if (result.statusCode == 200) {
        final words = result.body.split('\n');

        final parsedWords = <Word>[];

        for (var word in words) {
          parsedWords.add(Word(word: word.toString()));
        }

        return parsedWords;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveWordsToCache(List<Word> words) async {
    await _wordsBox.addAll(words);
  }

  @override
  Future<ResponseModel?> getWordFromDictionary(String item) async {
    try {
      final result = await _restClient.get(
        'https://api.dictionaryapi.dev/api/v2/entries/en/$item',
      );

      final response = ResponseModel(
        statusCode: result.statusCode!.toInt(),
        message: result.statusText.toString(),
      );
      if (result.statusCode == 200) {
        response.body = DictionaryWord.fromMap(result.body.first);
      } else {
        response.body = null;
      }
      return response;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> saveDictionaryWordToCache(DictionaryWord item) async {
    try {
      await _historyBox.add(item);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<DictionaryWord>> findWord(String wordToSearch, String box) async {
    final useBox = box == 'favorites' ? _favoritesBox : _historyBox;
    return useBox
        .toMap()
        .values
        .where((word) => word.word == wordToSearch)
        .toList();
  }

  @override
  Future<void> saveNewItemToHistory(DictionaryWord item) async =>
      await _historyBox.add(item);

  @override
  Future<List<DictionaryWord>> getAllFromHistory() async =>
      _historyBox.toMap().values.toList();

  @override
  Future<void> saveNewFavorite(DictionaryWord item) async {
    /* O Hive não permite salvar o mesmo objeto em mais de uma box; criando um novo objeto baseado no anterior.*/
    var newWord = DictionaryWord(
      word: item.word,
      phonetic: item.phonetic,
      phonetics: item.phonetics,
      meanings: item.meanings,
      sourceUrls: item.sourceUrls,
    );
    await _favoritesBox.add(newWord);
  }

  @override
  Future<void> removeFromFavorites(DictionaryWord item) async =>
      await item.delete();

  @override
  Future<List<DictionaryWord>> getAllFromFavorites() async =>
      _favoritesBox.toMap().values.toList();
}
