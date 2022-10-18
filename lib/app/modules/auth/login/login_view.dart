// ignore_for_file: use_build_context_synchronously

import 'package:dictionary/app/core/ui/constants_ui.dart';
import 'package:dictionary/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              decoration:
                  const BoxDecoration(color: ConstantsUi.kPrimaryColorDark),
              width: Get.width,
              height: Get.height,
            ),
            Positioned(
              top: 54,
              child: SizedBox(
                width: Get.width,
                child: const Text(
                  'Dictionary',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    color: ConstantsUi.kPrimaryColorWhite,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 16,
              child: Container(
                width: Get.width - 32,
                height: Get.height * 0.75,
                decoration: BoxDecoration(
                  //color: ConstantsUi.kPrimaryColorDarkAccent,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ConstantsUi.kPrimaryColorDarkAccent
                      : ConstantsUi.kPrimaryColorWhite,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                            //color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Obx(
                          () => TextFormField(
                            controller: controller.usernameController,
                            validator: (value) =>
                                controller.validateUsername(value),
                            decoration: InputDecoration(
                              labelText: 'username'.tr,
                              errorText: controller.credentialError.value
                                  ? 'invalid_credentials'.tr
                                  : null,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-z0-9]")),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Obx(
                          () => TextFormField(
                            controller: controller.passwordController,
                            validator: (value) =>
                                controller.validatePassword(value),
                            obscureText: controller.obscurePass.value,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    controller.obscurePass.toggle(),
                                icon: controller.obscurePass.value
                                    ? const Icon(PhosphorIcons.eyeClosed)
                                    : const Icon(PhosphorIcons.eye),
                              ),
                              labelText: 'password'.tr,
                              errorText: controller.credentialError.value
                                  ? 'invalid_credentials'.tr
                                  : null,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        SizedBox(
                          width: Get.width,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              final FormState? form =
                                  _loginFormKey.currentState;
                              if (form!.validate()) {
                                controller.attemptSignin();
                              }
                            },
                            child: Text('login'.tr),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: Get.width,
                          height: 50,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () async {
                                final result = await Get.toNamed(Routes.SIGNUP);
                                if (result == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'account_created'.tr,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'create_account'.tr,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
