import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:shalom_zen/enums/tile_audio_source.dart';
import 'package:shalom_zen/global.dart';
import 'package:shalom_zen/home/widget/music_tile.dart';
import 'package:shalom_zen/player/sound_player.dart';

class SoundPage extends StatelessWidget {
  const SoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    var random = Random();
    int randomNumber = random.nextInt(appFreqSounds.length);
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: 195,
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                    image: AssetImage(
                      "assets/cloud_relax.jpeg",
                    ),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Relax Sounds",
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Aeonik",
                      color: Colors.white),
                ),
                const Gap(8),
                const Text(
                  "Sometimes the most productive thing you can do is relax.",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Aeonik",
                      color: Colors.white),
                ),
                const Gap(16),
                ElevatedButton(
                    style: const ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size(125, 40)),
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SoundPlayer(
                            title:
                                appFreqSounds[randomNumber].entries.single.key,
                            subtitle: "Relax Frequency",
                            audioUrl: appFreqSounds[randomNumber]
                                .entries
                                .single
                                .value,
                            audioSource: TileAudioSource.assets),
                      ));
                    },
                    child: const Text(
                      "Play Now",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Aeonik",
                          color: Colors.black),
                    ))
              ],
            ),
          ),
          const Gap(16),
          Expanded(
            child: ListView.builder(
              itemCount: appFreqSounds.length,
              itemBuilder: (context, index) => MusicTile(
                title: appFreqSounds[index].entries.single.key,
                subtitle: "Relax Frequency",
                audioUrl: appFreqSounds[index].entries.single.value,
                audioSource: TileAudioSource.assets,
              ),
            ),
          )
        ],
      ),
    );
  }
}
