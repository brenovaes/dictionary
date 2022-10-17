import 'package:dictionary/app/controllers/hive_init_controller.dart';
import 'package:dictionary/app/core/bindings/application_bindings.dart';
import 'package:dictionary/app/core/translation/translation_keys.dart';
import 'package:dictionary/app/core/ui/dictionary_ui.dart';
import 'package:dictionary/app/core/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

Future<ThemeMode> _readTheme() async {
  final storage = GetStorage('settingsContainer');

  var returnTheme = ThemeMode.system;

  var theme = storage.read('theme');

  if (theme == 'light' || theme == null) {
    returnTheme = ThemeMode.light;
  }

  if (theme == 'dark') {
    returnTheme = ThemeMode.dark;
  }

  return returnTheme;
}

Future<String> _readLanguage() async {
  final storage = GetStorage('settingsContainer');

  final language = storage.read('language') ?? Utils.getLocaleFromPlatform();

  return language;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init('settingsContainer');

  await HiveInitController.init();

  final theme = await _readTheme();

  final language = await _readLanguage();

  runApp(
    DictionaryMainApp(
      theme: theme,
      language: language,
    ),
  );
}

class DictionaryMainApp extends StatelessWidget {
  final ThemeMode theme;
  final String language;

  const DictionaryMainApp({
    super.key,
    required this.theme,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Dictionary",
      theme: DictionaryUi.theme,
      darkTheme: DictionaryUi.darkTheme,
      themeMode: theme,
      initialRoute: AppPages.INITIAL,
      initialBinding: ApplicationBindings(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      locale: Locale(language),
      fallbackLocale: const Locale('en', 'US'),
      translations: TranslationKeys(),
    );
  }
}
