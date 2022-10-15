import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'signup_controller.dart';

class SignupView extends GetView<SignupController> {
  SignupView({super.key});

  final GlobalKey<FormState> _signinFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _signinFormKey,
            child: Column(
              children: [
                Obx(
                  () => TextFormField(
                    controller: controller.usernameController,
                    validator: (value) => controller.validateUsername(value),
                    decoration: InputDecoration(
                      labelText: "Username",
                      errorText: controller.usernameAlreadyRegistered.value
                          ? 'Username already registered'
                          : null,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-z0-9]")),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(
                  () => TextFormField(
                    controller: controller.passwordController,
                    validator: (value) => controller.validatePassword(value),
                    obscureText: controller.obscurePass.value,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () => controller.obscurePass.toggle(),
                        icon: controller.obscurePass.value
                            ? const Icon(PhosphorIcons.eyeClosed)
                            : const Icon(PhosphorIcons.eye),
                      ),
                      labelText: "Password",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: Get.width,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      final FormState? form = _signinFormKey.currentState;
                      if (form!.validate()) {
                        controller.attemptSignup();
                        //Get.off(() => const ConfirmationView());
                      }
                    },
                    child: /* controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : const  */
                        const Text(
                      'Finalizar cadastro',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
