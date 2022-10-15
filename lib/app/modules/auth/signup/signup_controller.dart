import 'package:dictionary/app/core/mixins/loader_mixin.dart';
import 'package:dictionary/app/models/user_model.dart';
import 'package:dictionary/app/repositories/auth/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController with LoaderMixin {
  final AuthRepository _authRepository;

  SignupController({
    required authRepository,
  }) : _authRepository = authRepository;

  // Variáveis observáveis
  final obscurePass = true.obs;
  final isLoading = false.obs;
  final usernameAlreadyRegistered = false.obs;

  // Outras variáveis
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Métodos de validação
  validateUsername(value) =>
      value.length < 8 ? 'Must contain at least 8 characters.' : null;

  validatePassword(value) =>
      value.length < 8 ? 'Must contain at least 8 characters.' : null;

  // Métodos sobrescritos
  @override
  void onInit() {
    super.onInit();
    loaderListener(isLoading);
  }

  // Métodos
  Future<void> attemptSignup() async {
    isLoading.toggle();
    usernameAlreadyRegistered.value = false;

    final newUser = User(
      username: usernameController.text,
      password: passwordController.text,
    );
    final response = await _authRepository.attemptSignup(newUser);

    isLoading.toggle();
    if (response!.statusCode == 201) {
      Get.back(result: true);
    } else if (response.statusCode == 422) {
      response.body['data'].first['campo'] == 'username'
          ? usernameAlreadyRegistered.value = true
          : false;
    }
  }
}
