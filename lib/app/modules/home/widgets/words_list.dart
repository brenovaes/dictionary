import 'package:dictionary/app/modules/home/home_controller.dart';
import 'package:dictionary/app/modules/home/widgets/word_card.dart';
import 'package:flutter/material.dart';

class WordsList extends StatelessWidget {
  final HomeController controller;
  final List<dynamic> list;

  const WordsList({
    super.key,
    required this.controller,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      controller: controller.scrollController,
      crossAxisCount: 3,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: list
          .map(
            (item) => WordCard(item: item),
          )
          .toList(),
    );
  }
}
