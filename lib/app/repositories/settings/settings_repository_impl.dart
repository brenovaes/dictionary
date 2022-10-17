import 'package:dictionary/app/core/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dictionary/app/repositories/settings/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final settingsContainer = GetStorage('settingsContainer');

  @override
  void saveSetting(String key, value) {
    settingsContainer.write(key, value);
  }

  @override
  void deleteJwt() {
    settingsContainer.remove('jwt');
  }

  @override
  Map<String, dynamic> getSettings() {
    var settings = <String, dynamic>{};
    settings.addAll({
      'theme': settingsContainer.read('theme') ?? 'system',
      'language':
          settingsContainer.read('language') ?? Utils.getLocaleFromPlatform(),
      'jwt': settingsContainer.read('jwt'),
    });
    return settings;
  }

  @override
  String getJwt() => settingsContainer.read('jwt');
}
