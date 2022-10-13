import 'dart:io';

class Utils {
  Utils._();

  static String getLocaleFromPlatform() => Platform.localeName.toString();
}
