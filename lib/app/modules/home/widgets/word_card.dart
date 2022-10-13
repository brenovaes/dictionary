// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'package:dictionary/app/modules/home/widgets/modal_bottom_sheet_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dictionary/app/core/ui/constants_ui.dart';
import 'package:dictionary/app/models/dictionary_word_model.dart';
import 'package:dictionary/app/modules/home/home_controller.dart';

class WordCard extends StatelessWidget {
  final dynamic item;

  WordCard({
    super.key,
    required this.item,
  });

  final HomeController controller = Get.find();

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
            controller.isLoading.toggle();
            final historyByWord =
                await controller.findWord(item.word, 'history');
            final favoritesByWord =
                await controller.findWord(item.word, 'favorites');

            if (historyByWord.isEmpty) {
              final data = await controller.getWordFromDictionary(item.word);
              controller.isLoading.toggle();

              if (data['status'] == true) {
                if (controller.choice == 0) {
                  controller.saveNewItemToHistory(data['body']);
                }
                await _showModal(context, data['body'], false);
                _refreshLists();
              } else if (data['status'] == false) {
                const snackBar = SnackBar(
                  content: Text(
                    'No definition found for this word/phrase.',
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            } else {
              controller.isLoading.toggle();
              final isFavorited = favoritesByWord.isEmpty ? false : true;
              final element = favoritesByWord.isEmpty
                  ? historyByWord.first
                  : favoritesByWord.first;
              await _showModal(context, element, isFavorited);
              _refreshLists();
            }
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

  Future<void> _showModal(
      BuildContext context, DictionaryWord item, bool isFavorited) async {
    return await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return ModalBottomSheetContent(
          item: item,
          controller: controller,
          isFavorited: isFavorited,
        );
      },
      clipBehavior: Clip.antiAlias,
      isDismissible: false,
      isScrollControlled: true,
    );
  }

  void _refreshLists() {
    if (controller.choice == 2) {
      controller.getAllFromFavorites();
    }
  }
}
