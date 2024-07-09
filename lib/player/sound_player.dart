import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shalom_zen/enums/tile_audio_source.dart';
import 'package:shalom_zen/global.dart';

class SoundPlayer extends StatefulWidget {
  final String title;
  final String subtitle;
  final String audioUrl;
  final TileAudioSource audioSource;

  const SoundPlayer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.audioUrl,
    required this.audioSource,
  });

  @override
  State<SoundPlayer> createState() => _SoundPlayerState();
}

class _SoundPlayerState extends State<SoundPlayer> {
  final AudioPlayer appAudioPlayer = AudioPlayer();
  final AudioPlayer appBackgroundAudioPlayer = AudioPlayer();
  Duration? duration = Duration.zero;
  Duration? position = Duration.zero;

  bool isShowOptions = false;

  String formatDurationPosition(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void handleSeek(double value) {
    appAudioPlayer.seek(Duration(seconds: value.toInt()));
  }

  Future<void> handlePlayPause() async {
    if (appAudioPlayer.playing) {
      await appAudioPlayer.pause();
      await appBackgroundAudioPlayer.pause();
    } else {
      appAudioPlayer.setVolume(0.3);

      appBackgroundAudioPlayer.setVolume(1.0);
      appAudioPlayer.play().whenComplete(
        () {
          if (appBackgroundAudioPlayer.playing) {
            appBackgroundAudioPlayer.pause();
          }
        },
      );
      await Future.delayed(Durations.extralong4);

      appBackgroundAudioPlayer.play();
    }
  }

  @override
  void initState() {
    super.initState();
    var random = Random();
    int randomNumber = random.nextInt(appFreqSounds.length);

    if (widget.audioSource == TileAudioSource.url) {
      appAudioPlayer.setUrl(widget.audioUrl);
      appBackgroundAudioPlayer
          .setAsset(appFreqSounds[randomNumber].entries.single.value);
    } else {
      appAudioPlayer.setAsset(widget.audioUrl);
    }

    appAudioPlayer.durationStream.listen(
      (event) => setState(() {
        duration = event;
      }),
    );
    appAudioPlayer.positionStream.listen(
      (event) => setState(() {
        position = event;
      }),
    );
  }

  @override
  void dispose() {
    appAudioPlayer.dispose();
    appBackgroundAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (position != null && duration != null && position == duration) {
    //   appBackgroundAudioPlayer.pause();
    // }
    double pitch = appAudioPlayer.pitch;
    double volume = appAudioPlayer.volume;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Image.asset(
              "assets/sound_play_background.png",
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, top: 8),
                        child: GestureDetector(
                          onTap: () {
                            appAudioPlayer.dispose();
                            appBackgroundAudioPlayer.dispose();
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.15),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (widget.audioSource == TileAudioSource.url)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16, top: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isShowOptions = !isShowOptions;
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.15),
                              child: const Icon(
                                Icons.more_vert_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Gap(MediaQuery.of(context).size.height * 0.25),
                SizedBox(
                  height: 100,
                  width: 96,
                  child: Image.asset("assets/shalom_zen_logo.png"),
                ),
                Gap(MediaQuery.of(context).size.height * 0.2),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Gap(8),
                Text(
                  widget.subtitle,
                  style: TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                const Gap(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDurationPosition(position ?? Duration.zero),
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Urbanist",
                        ),
                      ),
                      Text(
                        formatDurationPosition(duration ?? Duration.zero),
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Urbanist",
                        ),
                      ),
                    ],
                  ),
                ),
                Slider(
                  activeColor: Colors.white,
                  inactiveColor: Colors.white.withOpacity(0.15),
                  min: 0.0,
                  max: (duration ?? Duration.zero).inSeconds.toDouble(),
                  value: (position ?? Duration.zero).inSeconds.toDouble(),
                  onChanged: (value) {
                    handleSeek(value);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        handleSeek(
                          (position ?? Duration.zero).inSeconds.toDouble() -
                              30.0,
                        );
                      },
                      child: ImageIcon(
                        const AssetImage(
                          "assets/icon-30-previews.png",
                        ),
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    appAudioPlayer.playing
                        ? GestureDetector(
                            onTap: handlePlayPause,
                            child: CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.white.withOpacity(0.15),
                              child: const Icon(
                                Icons.pause,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: handlePlayPause,
                            child: CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.white.withOpacity(0.15),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(CupertinoIcons.volume_down)),
                    GestureDetector(
                      onTap: () {
                        handleSeek(
                          (position ?? Duration.zero).inSeconds.toDouble() +
                              30.0,
                        );
                      },
                      child: ImageIcon(
                        const AssetImage("assets/icon-30-next.png"),
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Visibility(
                visible: isShowOptions,
                child: SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 52.0, right: 16),
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 80,
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // setState(() {
                                  //   // isShareButtonTapped.removeAt(index);
                                  //   isShareButtonTapped = true;
                                  // });
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.waveform,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    const Text(
                                      "Voice Pitch",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Expanded(child: Gap(2)),
                                    InkWell(
                                      splashColor: Colors.green[200],
                                      onTap: () {
                                        appAudioPlayer.setPitch(pitch + 0.5);
                                      },
                                      child: const Icon(
                                        CupertinoIcons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Gap(8),
                                    InkWell(
                                      splashColor: Colors.green[200],
                                      onTap: () {
                                        appAudioPlayer.setPitch(pitch - 0.5);
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Gap(16),
                              Row(
                                children: [
                                  const Icon(
                                    CupertinoIcons.volume_down,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  const Text(
                                    "Voice Volume",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Expanded(child: Gap(2)),
                                  InkWell(
                                    splashColor: Colors.green[200],
                                    onTap: () {
                                      appAudioPlayer.setVolume(volume + 0.5);
                                    },
                                    child: const Icon(
                                      CupertinoIcons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Gap(8),
                                  InkWell(
                                    splashColor: Colors.green[200],
                                    onTap: () {
                                      appAudioPlayer.setVolume(volume - 0.5);
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ))),
                ),
              )),
        ],
      ),
    );
  }
}
