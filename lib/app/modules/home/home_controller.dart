import 'package:dictionary/app/repositories/words/words_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final WordsRepository _wordsRepository;

  HomeController({required wordsRepository})
      : _wordsRepository = wordsRepository;

  final _choice = 0.obs;
  int get choice => _choice.value;
  set choice(value) => _choice.value = value;

  void getAllWords() async {
    final result = await _wordsRepository.getAllWords();
    print(result);
  }
}
