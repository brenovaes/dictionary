import 'package:dictionary/app/core/ui/constants_ui.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'home_controller.dart';
import 'widgets/custom_choice_chip.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.scrollController.addListener(
      () {
        var showScrollToTopButton =
            controller.scrollController.position.viewportDimension + 1;

        controller.showScrollToTopButton =
            controller.scrollController.position.pixels > showScrollToTopButton
                ? true
                : false;
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dictionary'),
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
            () => controller.wordsList.isEmpty
                ? const Expanded(
                    child: Center(child: Text('No words found.')),
                  )
                : Expanded(
                    child: GridView.count(
                      controller: controller.scrollController,
                      crossAxisCount: 3,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      children: controller.wordsList
                          .map((item) => Material(
                                child: Ink(
                                  decoration: const BoxDecoration(
                                    color: ConstantsUi.kPrimaryColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          item.word,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
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
}

class OptionsRow extends StatelessWidget {
  OptionsRow({
    super.key,
  });

  final HomeController controller = Get.find();

  final List<String> chipsLabels = [
    'Words list',
    'History',
    'Favorites',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        chipsLabels.length,
        (index) => CustomChoiceChip(
          controller: controller,
          chipsLabels: chipsLabels,
          index: index,
        ),
      ),
    );
  }
}
