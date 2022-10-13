// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:dictionary/app/core/ui/constants_ui.dart';
import 'package:dictionary/app/models/dictionary_word_model.dart';
import 'package:dictionary/app/models/word_model.dart';
import 'package:dictionary/app/modules/home/home_controller.dart';

class WordCard extends StatelessWidget {
  final WordModel item;

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
            final data = await controller.getWordFromDictionary(item);
            controller.isLoading.toggle();
            print(data);
            if (data['status'] == true) {
              await showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return ModalBottomSheetContent(
                    item: data['body'],
                    controller: controller,
                  );
                },
                clipBehavior: Clip.antiAlias,
                isDismissible: false,
                isScrollControlled: true,
              );
            } else if (data['status'] == false) {
              const snackBar = SnackBar(
                content: Text(
                  'No definition found for this word/phrase.',
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
}

class ModalBottomSheetContent extends StatefulWidget {
  DictionaryWordModel item;
  HomeController controller;

  ModalBottomSheetContent({
    super.key,
    required this.item,
    required this.controller,
  });

  @override
  State<ModalBottomSheetContent> createState() =>
      _ModalBottomSheetContentState();
}

class _ModalBottomSheetContentState extends State<ModalBottomSheetContent> {
  final player = AudioPlayer();
  late final duration;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        8,
      ),
      height: Get.height * 0.80,
      color: Colors.white,
      child: Column(
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
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
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
                    children: [
                      Text(
                        widget.item.word,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      widget.item.phonetic != null
                          ? Text(
                              widget.item.phonetic.toString(),
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                widget.item.phonetics.isNotEmpty &&
                        widget.item.phonetics.first?.audio != null &&
                        widget.item.phonetics.first?.audio != ''
                    ? Column(
                        children: [
                          const Divider(
                            thickness: 1,
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await player.play();
                                },
                                icon: const Icon(PhosphorIcons.playBold),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Obx(
                                () => Expanded(
                                  child: Slider(
                                    value: widget.controller.audioProgressValue,
                                    onChanged: (_) {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
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
                Column(
                  children: widget.item.meanings.mapIndexed((index, meaning) {
                    return ExpansionTile(
                      expandedAlignment: Alignment.centerLeft,
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      childrenPadding: const EdgeInsets.all(8),
                      title: Text(
                        widget.item.meanings[index].partOfSpeech.capitalizeFirst
                            .toString(),
                      ),
                      children: widget.item.meanings[index].definitions
                          .map((definition) {
                        return Text('• ${definition.definition}');
                      }).toList(),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _initAudioPlayer() async {
    duration = await player.setUrl(
      widget.item.phonetics.first?.audio as String,
    );
  }
}
