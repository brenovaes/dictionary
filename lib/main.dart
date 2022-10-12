import 'package:dictionary/app/core/bindings/application_bindings.dart';
import 'package:dictionary/app/core/ui/dictionary_ui.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Dictionary",
      theme: DictionaryUi.theme,
      darkTheme: DictionaryUi.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppPages.INITIAL,
      initialBinding: ApplicationBindings(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
