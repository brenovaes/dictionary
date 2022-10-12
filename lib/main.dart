import 'package:dictionary/app/core/bindings/application_bindings.dart';
import 'package:dictionary/app/core/ui/dictionary_ui.dart';
import 'package:dictionary/app/models/word_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/routes/app_pages.dart';

Future<void> _initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(WordModelAdapter());

  Box<WordModel> wordsBox = await Hive.openBox<WordModel>('words');

  Get.put<Box<WordModel>>(
    wordsBox,
    permanent: true,
  );
}

void main() async {
  await _initHive();

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
