abstract class SettingsRepository {
  void saveSetting(String key, dynamic value);
  void deleteJwt();
  Map<String, dynamic> getSettings();
  String getJwt();
}
