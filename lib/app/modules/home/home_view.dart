import 'package:dictionary/app/core/utils/utils.dart';
import 'package:dictionary/app/modules/home/widgets/filter_option.dart';
import 'package:dictionary/app/modules/home/widgets/options_row.dart';
import 'package:dictionary/app/modules/home/widgets/words_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:dictionary/app/core/ui/constants_ui.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.scrollController.addListener(
      () {
        var nextPageTrigger =
            controller.scrollController.position.maxScrollExtent;

        var showScrollToTopButton =
            controller.scrollController.position.viewportDimension + 1;

        if (controller.scrollController.position.pixels > nextPageTrigger &&
            controller.choice == 0 &&
            controller.filterOption == '') {
          controller.fetchMoreData();
        }

        controller.showScrollToTopButton =
            controller.scrollController.position.pixels > showScrollToTopButton
                ? true
                : false;
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dictionary'),
        actions: [
          PopupMenuButton(
            icon: Icon(
              PhosphorIcons.dotsThreeVertical,
              color: Theme.of(context).appBarTheme.titleTextStyle?.color,
            ),
            onSelected: (value) {
              switch (value) {
                case 'theme':
                  _buildThemeDialog();
                  break;
                case 'language':
                  _buildLanguageDialog();
                  break;
                case 'logout':
                  _buildLogoutDialog();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'theme',
                child: ListTile(
                  leading: const Icon(PhosphorIcons.moonFill),
                  title: Text('change_theme'.tr),
                ),
              ),
              PopupMenuItem(
                value: 'language',
                child: ListTile(
                  leading: const Icon(PhosphorIcons.translate),
                  title: Text('change_language'.tr),
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                child: ListTile(
                  leading: const Icon(PhosphorIcons.signOut),
                  title: Text('logout'.tr),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: OptionsRow(),
          ),
          const SizedBox(
            height: 8,
          ),
          Obx(
            () => controller.choice == 0
                ? SizedBox(
                    height: 50,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        Utils.listOptions.length,
                        (index) => FilterOption(
                          controller: controller,
                          label: Utils.listOptions[index]['label'],
                          value: Utils.listOptions[index]['value'],
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.choice == 0 && controller.filterOption == ''
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: Get.width,
                      child: Text(
                        'qty_word_loaded'.trParams({
                          'value': '${controller.count}',
                        }),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(
            height: 8,
          ),
          Obx(
            () {
              List<dynamic> list;
              switch (controller.choice) {
                case 0:
                  list = controller.wordsList;
                  break;
                case 1:
                  list = controller.historyList;
                  break;
                default:
                  list = controller.favoritesList;
                  break;
              }
              return list.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text('no_words'.tr),
                      ),
                    )
                  : Expanded(
                      child: WordsList(
                        controller: controller,
                        list: list,
                      ),
                    );
            },
          )
        ],
      ),
      floatingActionButton: Obx(
        () => Visibility(
          visible: controller.showScrollToTopButton,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () => controller.scrollToTop(),
            child: const Icon(
              PhosphorIcons.caretUp,
              color: ConstantsUi.kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _buildThemeDialog() async {
    final String? backupThemeChoice = controller.theme;
    return Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text('choose_theme'.tr),
          content: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(
                  value: 'light',
                  groupValue: controller.theme,
                  title: Text('light'.tr),
                  onChanged: (value) => controller.theme = value,
                ),
                RadioListTile(
                  value: 'dark',
                  groupValue: controller.theme,
                  title: Text('dark'.tr),
                  onChanged: (value) => controller.theme = value,
                ),
                RadioListTile(
                  value: 'system',
                  groupValue: controller.theme,
                  title: Text('match_system'.tr),
                  onChanged: (value) => controller.theme = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.theme = backupThemeChoice;
                Get.close(1);
              },
              child: Text('cancel'.tr),
            ),
            TextButton(
              onPressed: () {
                controller.setPreference(
                  'theme',
                  controller.theme,
                );
                switch (controller.theme) {
                  case 'light':
                    Get.changeThemeMode(ThemeMode.light);
                    break;
                  case 'dark':
                    Get.changeThemeMode(ThemeMode.dark);
                    break;
                  default:
                    Get.changeThemeMode(ThemeMode.system);
                    break;
                }
                Get.close(1);
              },
              child: Text('save'.tr),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<dynamic> _buildLanguageDialog() async {
    final String? backupLanguageChoice = controller.language;

    return Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text('choose_language'.tr),
          content: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(
                  value: 'en_US',
                  groupValue: controller.language,
                  title: const Text('English'),
                  onChanged: (value) => controller.language = value,
                ),
                RadioListTile(
                  value: 'pt_BR',
                  groupValue: controller.language,
                  title: const Text('Português (Brasil)'),
                  onChanged: (value) => controller.language = value,
                ),
                /* RadioListTile(
                  value: 'es_ES',
                  groupValue: controller.language,
                  title: const Text('Español'),
                  onChanged: (value) => controller.language = value,
                ), */
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.language = backupLanguageChoice;
                Get.close(1);
              },
              child: Text('cancel'.tr),
            ),
            Obx(
              () => TextButton(
                onPressed: controller.language == 'pt_BR' ||
                        controller.language ==
                            'en_US' /*  ||
                        controller.language == 'es_ES' */
                    ? () {
                        controller.setPreference(
                          'language',
                          controller.language,
                        );
                        Get.updateLocale(Locale(controller.language as String));
                        Get.close(1);
                      }
                    : null,
                child: Text('save'.tr),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<dynamic> _buildLogoutDialog() async {
    return Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: Text('sure'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('cancel'.tr),
          ),
          TextButton(
            onPressed: () => controller.logout(),
            child: Text('logout'.tr),
          ),
        ],
      ),
    );
  }
}
