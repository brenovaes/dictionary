import 'package:dictionary/app/core/rest_client/rest_client.dart';
import 'package:dictionary/app/repositories/settings/settings_repository.dart';
import 'package:dictionary/app/repositories/settings/settings_repository_impl.dart';
import 'package:get/get.dart';

class ApplicationBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => RestClient(),
      fenix: true,
    );

    Get.put<SettingsRepository>(
      SettingsRepositoryImpl(),
      permanent: true,
    );
  }
}
