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
                  //_buildLanguageDialog();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'theme',
                child: ListTile(
                  leading: Icon(PhosphorIcons.moonFill),
                  title: Text('Change theme'),
                ),
              ),
              const PopupMenuItem(
                value: 'language',
                child: ListTile(
                  leading: Icon(PhosphorIcons.translate),
                  title: Text('Change language'),
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
                        '${controller.count} words loaded, scroll and see more',
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
                  ? const Expanded(
                      child: Center(
                        child: Text('No words found.'),
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
          title: const Text('Choose theme'),
          content: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(
                  value: 'light',
                  groupValue: controller.theme,
                  title: const Text('Light'),
                  onChanged: (value) => controller.theme = value,
                ),
                RadioListTile(
                  value: 'dark',
                  groupValue: controller.theme,
                  title: const Text('Dark'),
                  onChanged: (value) => controller.theme = value,
                ),
                RadioListTile(
                  value: 'system',
                  groupValue: controller.theme,
                  title: const Text('Match system\'s theme'),
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
              child: const Text('Cancel'),
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
              child: const Text('Save'),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
