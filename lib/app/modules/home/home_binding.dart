import 'package:dictionary/app/repositories/words/words_repository.dart';
import 'package:dictionary/app/repositories/words/words_repository_impl.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WordsRepository>(
      () => WordsRepositoryImpl(
        restClient: Get.find(),
      ),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(
        wordsRepository: Get.find<WordsRepository>(),
      ),
    );
  }
}
