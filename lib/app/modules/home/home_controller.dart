import 'package:dictionary/app/core/mixins/loader_mixin.dart';
import 'package:dictionary/app/models/word_model.dart';
import 'package:dictionary/app/repositories/words/words_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with LoaderMixin {
  final WordsRepository _wordsRepository;

  HomeController({required wordsRepository})
      : _wordsRepository = wordsRepository;

  // Variáveis observáveis
  final _isLoading = false.obs;
  final wordsList = <WordModel>[].obs;

  // Outras variáveis
  late final ScrollController scrollController;

  // Variáveis observáveis com getters e setters
  final _showScrollToTopButton = false.obs;
  bool get showScrollToTopButton => _showScrollToTopButton.value;
  set showScrollToTopButton(bool value) => _showScrollToTopButton.value = value;

  final _choice = 0.obs;
  int get choice => _choice.value;
  set choice(value) => _choice.value = value;

  // Métodos sobrescritos
  @override
  void onInit() {
    super.onInit();
    loaderListener(_isLoading);
    scrollController = ScrollController();
  }

  @override
  void onReady() async {
    super.onReady();
    getAllWordsFromCache();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  // Métodos
  void getAllWordsFromCache() async {
    _isLoading.toggle();

    final wordsFromCache = await _wordsRepository.getAllWordsFromCache();

    if (wordsFromCache.isEmpty) {
      final response = await _wordsRepository.getAllWordsFromNetwork();
      if (response != null) {
        wordsList.assignAll(response);
        await _wordsRepository.saveWordsToCache(response);
      }
    } else {
      wordsList.assignAll(wordsFromCache);
    }
    _isLoading.toggle();
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
