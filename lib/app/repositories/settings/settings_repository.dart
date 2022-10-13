abstract class SettingsRepository {
  void saveSetting(String key, dynamic value);
  Map<String, dynamic> getSettings();
}
