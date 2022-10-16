import 'package:dictionary/app/core/mixins/loader_mixin.dart';
import 'package:dictionary/app/models/user_model.dart';
import 'package:dictionary/app/repositories/auth/auth_repository.dart';
import 'package:dictionary/app/repositories/settings/settings_repository.dart';
import 'package:dictionary/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with LoaderMixin {
  final AuthRepository _authRepository;
  final SettingsRepository _settingsRepository;

  LoginController({
    required authRepository,
    required SettingsRepository settingsRepository,
  })  : _authRepository = authRepository,
        _settingsRepository = settingsRepository;

  // Variáveis observáveis
  final obscurePass = true.obs;
  final isLoading = false.obs;
  final credentialError = false.obs;

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
  void onReady() {
    super.onReady();
    loaderListener(isLoading);
  }

  // Métodos
  Future<void> attemptSignin() async {
    isLoading.toggle();
    credentialError.value = false;

    final user = User(
      username: usernameController.text,
      password: passwordController.text,
    );

    final result = await _authRepository.attemptSignin(user);
    isLoading.toggle();

    if (result!.statusCode == 200) {
      _settingsRepository.saveSetting('jwt', result.body['token']);
      Get.offAllNamed(Routes.HOME);
    } else if (result.statusCode == 401) {
      credentialError.value = true;
    }
  }
}
