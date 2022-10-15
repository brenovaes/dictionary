import 'package:dictionary/app/repositories/settings/settings_repository.dart';
import 'package:dictionary/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final SettingsRepository _settingsRepository;

  SplashController({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  void onReady() async {
    super.onReady();
    await _checkIsLogged();
  }

  Future<void> _checkIsLogged() async {
    final isLogged = _settingsRepository.getSettings();

    if (isLogged['jwt'] != null) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
