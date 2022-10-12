import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin LoaderMixin on GetxController {
  void loaderListener(RxBool isLoading) {
    ever(isLoading, (_) async {
      if (isLoading.isTrue) {
        await Get.dialog(
          WillPopScope(
            child: const Center(
              child: CircularProgressIndicator(),
            ),
            onWillPop: () async => false,
          ),
          barrierDismissible: false,
        );
      } else {
        Get.back();
      }
    });
  }
}
