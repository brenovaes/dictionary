import 'package:dictionary/app/core/bindings/application_bindings.dart';
import 'package:dictionary/app/core/ui/dictionary_ui.dart';
import 'package:dictionary/app/models/definition_model.dart';
import 'package:dictionary/app/models/dictionary_word_model.dart';
import 'package:dictionary/app/models/meaning_model.dart';
import 'package:dictionary/app/models/phonetic_model.dart';
import 'package:dictionary/app/models/word_model.dart';
import 'package:dictionary/app/repositories/settings/settings_repository.dart';
import 'package:dictionary/app/repositories/settings/settings_repository_impl.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/routes/app_pages.dart';

Future<void> _initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(WordAdapter());
  Hive.registerAdapter(DictionaryWordAdapter());
  Hive.registerAdapter(DefinitionAdapter());
  Hive.registerAdapter(MeaningAdapter());
  Hive.registerAdapter(PhoneticAdapter());

  Box<Word> wordsBox = await Hive.openBox<Word>('words');
  Box<DictionaryWord> favoritesBox =
      await Hive.openBox<DictionaryWord>('favorites');
  Box<DictionaryWord> historyBox =
      await Hive.openBox<DictionaryWord>('history');

  Get.put<Box<Word>>(
    wordsBox,
    permanent: true,
  );
  Get.put<Box<DictionaryWord>>(
    favoritesBox,
    permanent: true,
    tag: 'favorites',
  );
  Get.put<Box<DictionaryWord>>(
    historyBox,
    permanent: true,
    tag: 'history',
  );
}

_initGetStorage() async {
  await GetStorage.init('settingsContainer');
  Get.put<SettingsRepository>(
    SettingsRepositoryImpl(),
    permanent: true,
  );
}

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initGetStorage();

  await _initHive();

  final theme = await _readTheme();

  runApp(
    DictionaryMainApp(
      theme: theme,
    ),
  );
}

class DictionaryMainApp extends StatelessWidget {
  final ThemeMode theme;

  const DictionaryMainApp({
    super.key,
    required this.theme,
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
    );
  }
}
