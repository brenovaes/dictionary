import 'package:dictionary/app/repositories/auth/auth_repository.dart';
import 'package:get/get.dart';

import 'signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(
      () => SignupController(
        authRepository: Get.find<AuthRepository>(),
      ),
    );
  }
}
