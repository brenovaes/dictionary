import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'home_controller.dart';
import 'widgets/custom_choice_chip.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
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
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: List.generate(
                50000,
                (index) => Container(
                  decoration: const BoxDecoration(
                    color: Colors.amberAccent,
                  ),
                  child: Center(
                    child: Text(
                      index.toString(),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
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
    'Favorites',
    'Last viewed',
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
