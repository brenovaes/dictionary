import 'package:dictionary/app/modules/home/home_controller.dart';
import 'package:dictionary/app/modules/home/widgets/custom_choice_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionsRow extends StatelessWidget {
  OptionsRow({
    super.key,
  });

  final HomeController controller = Get.find();

  final List<String> chipsLabels = [
    'words_list'.tr,
    'history'.tr,
    'favorites'.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        chipsLabels.length,
        (index) => Expanded(
          child: CustomChoiceChip(
            controller: controller,
            chipsLabels: chipsLabels,
            index: index,
          ),
        ),
      ),
    );
  }
}
