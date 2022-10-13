import 'package:dictionary/app/core/ui/constants_ui.dart';
import 'package:dictionary/app/models/dictionary_word_model.dart';
import 'package:dictionary/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:collection/collection.dart';

class ModalBottomSheetContent extends StatefulWidget {
  DictionaryWord item;
  HomeController controller;
  bool isFavorited;

  ModalBottomSheetContent({
    super.key,
    required this.item,
    required this.controller,
    required this.isFavorited,
  });

  @override
  State<ModalBottomSheetContent> createState() =>
      _ModalBottomSheetContentState();
}

class _ModalBottomSheetContentState extends State<ModalBottomSheetContent> {
  late final AudioPlayer? player;
  late final Duration? duration;
  final HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    if (widget.item.phonetics.isNotEmpty &&
        widget.item.phonetics.first?.audio != null &&
        widget.item.phonetics.first?.audio != '') {
      player = AudioPlayer();
      //_initAudioPlayer();
    } else {
      player = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (player != null) {
      player!.dispose();
    }
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
                onPressed: () async {
                  var actualState = widget.isFavorited;

                  actualState
                      ? await controller.removeFromFavorites(widget.item)
                      : await controller.saveNewFavorite(widget.item);

                  setState(() {
                    widget.isFavorited = !actualState;
                  });
                },
                icon: widget.isFavorited
                    ? const Icon(
                        PhosphorIcons.heartFill,
                        color: Colors.red,
                        size: 32,
                      )
                    : const Icon(
                        PhosphorIcons.heart,
                        size: 32,
                      ),
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
                                  _initAudioPlayer();
                                  await player!.play();
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
    duration = await player!.setUrl(
      widget.item.phonetics.first?.audio as String,
    );
  }
}
