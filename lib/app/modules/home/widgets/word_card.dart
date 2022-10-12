import 'package:dictionary/app/core/ui/constants_ui.dart';
import 'package:dictionary/app/models/word_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class WordCard extends StatelessWidget {
  final WordModel item;

  const WordCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: const BoxDecoration(
          color: ConstantsUi.kPrimaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: InkWell(
          onTap: () async {
            await showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return const ModalBottomSheetContent();
              },
              clipBehavior: Clip.antiAlias,
              isDismissible: false,
              isScrollControlled: true,
            );
          },
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
    );
  }
}

class ModalBottomSheetContent extends StatelessWidget {
  const ModalBottomSheetContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        8,
      ),
      height: Get.height * 0.80,
      color: Colors.white,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(PhosphorIcons.x),
              ),
              IconButton(
                onPressed: () => print('save'),
                icon: const Icon(PhosphorIcons.heart),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 200,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ConstantsUi.kPrimaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'hello',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '/həˈləʊ/',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            thickness: 1,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(PhosphorIcons.playBold),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
          const Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: Get.width,
              child: const Text(
                'Meanings',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
          ExpansionTile(
            expandedAlignment: Alignment.centerLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: const EdgeInsets.all(8),
            title: const Text('Noun'),
            children: const [
              Text(
                '1) A solid or hollow sphere, or roughly spherical mass. (e.g. a ball of spittle; a fecal ball)',
              ),
              Text(
                '2) A round or ellipsoidal object.',
              ),
            ],
          ),
          ExpansionTile(
            expandedAlignment: Alignment.centerLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: const EdgeInsets.all(8),
            title: const Text('Verb'),
            children: const [
              Text(
                '1) To form or wind into a ball. (e.g. o ball cotton)',
              ),
              Text(
                '2) To heat in a furnace and form into balls for rolling.',
              ),
              Text(
                '3) To have sexual intercourse with.',
              ),
              Text(
                '4) To gather balls which cling to the feet, as of damp snow or clay; to gather into balls.',
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Previous'),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
