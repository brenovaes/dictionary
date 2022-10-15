import 'package:dictionary/app/repositories/auth/auth_repository.dart';
import 'package:dictionary/app/repositories/auth/auth_repository_impl.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        restClient: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<LoginController>(
      () => LoginController(
        authRepository: Get.find<AuthRepository>(),
        settingsRepository: Get.find(),
      ),
    );
  }
}
