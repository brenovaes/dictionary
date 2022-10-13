import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dictionary/app/core/ui/constants_ui.dart';
import 'package:dictionary/app/modules/home/home_controller.dart';

class CustomChoiceChip extends StatelessWidget {
  const CustomChoiceChip({
    super.key,
    required this.controller,
    required this.chipsLabels,
    required this.index,
  });

  final HomeController controller;
  final List<String> chipsLabels;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ChoiceChip(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        onSelected: (value) => controller.onSelectedChoice(value, index),
        selected: controller.choice == index,
        label: Text(
          chipsLabels[index],
        ),
        selectedColor: ConstantsUi.kPrimaryColor,
        elevation: 0,
        pressElevation: 0,
        labelStyle: TextStyle(
          color: controller.choice == index
              ? Colors.white
              : Theme.of(context).appBarTheme.titleTextStyle?.color,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              14,
            ),
          ),
          side: BorderSide(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}
