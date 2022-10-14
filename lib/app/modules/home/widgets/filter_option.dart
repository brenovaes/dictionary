import 'package:dictionary/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterOption extends StatelessWidget {
  final HomeController controller;
  final String label;
  final String? value;

  const FilterOption({
    super.key,
    required this.controller,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Obx(
        () => TextButton(
          onPressed: () => controller.filterOption = value,
          child: RichText(
            text: TextSpan(
              text: label,
              style: controller.filterOption == value
                  ? Theme.of(context).textTheme.bodyText1!.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )
                  : Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ),
    );
  }
}
