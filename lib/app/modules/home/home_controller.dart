import 'package:dictionary/app/core/mixins/loader_mixin.dart';
import 'package:dictionary/app/models/dictionary_word_model.dart';
import 'package:dictionary/app/models/word_model.dart';
import 'package:dictionary/app/repositories/words/words_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with LoaderMixin {
  final WordsRepository _wordsRepository;

  HomeController({required wordsRepository})
      : _wordsRepository = wordsRepository;

  // Variáveis observáveis
  final isLoading = false.obs;
  final wordsList = <Word>[].obs;
  final historyList = <DictionaryWord>[].obs;
  final favoritesList = <DictionaryWord>[].obs;

  // Outras variáveis
  late final ScrollController scrollController;

  // Variáveis observáveis com getters e setters
  final _showScrollToTopButton = false.obs;
  bool get showScrollToTopButton => _showScrollToTopButton.value;
  set showScrollToTopButton(bool value) => _showScrollToTopButton.value = value;

  final _count = 0.obs;
  int get count => _count.value;
  set count(value) => _count.value = value;

  final _choice = 0.obs;
  int get choice => _choice.value;
  set choice(value) => _choice.value = value;

  final _audioProgressValue = 0.0.obs;
  double get audioProgressValue => _audioProgressValue.value;
  set audioProgressValue(value) => _audioProgressValue.value = value;

  //Métodos de validação
  onChangedAudioProgress(value) => audioProgressValue = value;

  onSelectedChoice(value, index) async {
    if (index == 1) {
      await getAllFromHistory();
    } else if (index == 2) {
      await getAllFromFavorites();
    }
    choice = index;
  }

  // Métodos sobrescritos
  @override
  void onInit() {
    super.onInit();
    loaderListener(isLoading);
    scrollController = ScrollController();
  }

  @override
  void onReady() async {
    super.onReady();
    getWordsFromCache();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  // Métodos
  void getWordsFromCache() async {
    List<Word>? wordsFromCache;
    isLoading.toggle();

    wordsFromCache = await _wordsRepository.getWordsFromCache();

    if (wordsFromCache.isEmpty) {
      final response = await _wordsRepository.getAllWordsFromNetwork();
      if (response != null) {
        await _wordsRepository.saveWordsToCache(response);
        wordsFromCache = await _wordsRepository.getWordsFromCache();
      }
    }
    count += wordsFromCache.length;
    wordsList.addAll(wordsFromCache);
    isLoading.toggle();
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  Future<void> getAllFromHistory() async {
    isLoading.toggle();
    final history = await _wordsRepository.getAllFromHistory();
    history.sort((DictionaryWord a, DictionaryWord b) =>
        a.word.toLowerCase().compareTo(b.word.toLowerCase()));
    historyList.assignAll(history);
    isLoading.toggle();
  }

  Future<void> getAllFromFavorites() async {
    isLoading.toggle();
    final favorites = await _wordsRepository.getAllFromFavorites();
    favorites.sort((DictionaryWord a, DictionaryWord b) =>
        a.word.toLowerCase().compareTo(b.word.toLowerCase()));
    favoritesList.assignAll(favorites);
    isLoading.toggle();
  }

  Future<Map<String, dynamic>> getWordFromDictionary(String word) async {
    final result = await _wordsRepository.getWordFromDictionary(word);
    final response = <String, dynamic>{};
    if (result!.statusCode == 200) {
      response.addAll({
        'status': true,
        'body': result.body,
      });
    } else if (result.statusCode == 404) {
      response.addAll({
        'status': false,
        'body': null,
      });
    } else {
      response.addAll({
        'status': null,
        'body': result.body,
      });
    }
    return response;
  }

  Future<void> saveNewItemToHistory(DictionaryWord item) async {
    final isViewed = await findWord(item.word, 'history');
    if (isViewed.isEmpty) {
      await _wordsRepository.saveNewItemToHistory(item);
    }
  }

  Future<List<DictionaryWord>> findWord(String word, String box) async =>
      await _wordsRepository.findWord(word, box);

  Future<void> removeFromFavorites(DictionaryWord item) async =>
      await _wordsRepository.removeFromFavorites(item);

  Future<void> saveNewFavorite(DictionaryWord item) async =>
      await _wordsRepository.saveNewFavorite(item);

  Future<void> fetchMoreData() async {
    if (isLoading.isFalse) {
      isLoading.toggle();
      final wordsQuery =
          await _wordsRepository.getWordsFromCache(offset: count);
      isLoading.toggle();
      count += wordsQuery.length;
      wordsList.addAll(wordsQuery);
    }
  }
}
