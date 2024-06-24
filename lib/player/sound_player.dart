import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shalom_zen/enums/tile_audio_source.dart';
import 'package:shalom_zen/global.dart';

class SoundPlayer extends StatefulWidget {
  final String title;
  final String subtitle;
  final String audioUrl;
  final TileAudioSource audioSource;
  const SoundPlayer(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.audioUrl,
      required this.audioSource});

  @override
  State<SoundPlayer> createState() => _SoundPlayerState();
}

class _SoundPlayerState extends State<SoundPlayer> {
  Duration? duration = Duration.zero;
  Duration? position = Duration.zero;

  formatDurationPosition(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds;
    return "${minutes.truncate()}:${seconds.toString().length > 2 ? seconds.toString().substring(0, 2) : seconds.toString().length < 2 ? seconds.toString().padLeft(2, "0") : seconds.toString()}";
  }

  handleSeek(double value) {
    appAudioPlayer.seek(Duration(seconds: value.toInt()));
  }

  handlePlayPause() {
    if (appAudioPlayer.playing) {
      appAudioPlayer.pause();
    } else {
      appAudioPlayer.play();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.audioSource == TileAudioSource.url
        ? appAudioPlayer.setUrl(widget.audioUrl)
        : appAudioPlayer.setAsset(widget.audioUrl);

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
    // TODO: implement dispose
    super.dispose();
    appAudioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              )),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.15),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          )),
                    ),
                  ),
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
                  style: TextStyle(
                      fontFamily: "Urbanist",
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Gap(8),
                Text(
                  widget.subtitle,
                  style: TextStyle(
                      fontFamily: "Urbanist",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.5)),
                ),
                Gap(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDurationPosition(position ?? Duration.zero),
                        style: TextStyle(
                            color: Colors.white, fontFamily: "Urbanist"),
                      ),
                      Text(
                        formatDurationPosition(duration ?? Duration.zero),
                        style: TextStyle(
                            color: Colors.white, fontFamily: "Urbanist"),
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
                    ImageIcon(
                      AssetImage("assets/last-play-fill.png"),
                      color: Colors.white.withOpacity(0.5),
                    ),
                    GestureDetector(
                      onTap: () {
                        handleSeek(
                            (position ?? Duration.zero).inSeconds.toDouble() -
                                30.0);
                      },
                      child: ImageIcon(
                        AssetImage(
                          "assets/icon-30-previews.png",
                        ),
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    appAudioPlayer.playing
                        ? GestureDetector(
                            onTap: () {
                              handlePlayPause();
                            },
                            child: CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.white.withOpacity(0.15),
                                child: Icon(
                                  Icons.pause,
                                  color: Colors.white,
                                )),
                          )
                        : GestureDetector(
                            onTap: () {
                              handlePlayPause();
                            },
                            child: CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.white.withOpacity(0.15),
                                child: Icon(Icons.play_arrow_rounded,
                                    color: Colors.white)),
                          ),
                    GestureDetector(
                      onTap: () {
                        handleSeek(
                            (position ?? Duration.zero).inSeconds.toDouble() +
                                30.0);
                      },
                      child: ImageIcon(
                        AssetImage("assets/icon-30-next.png"),
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    ImageIcon(
                      AssetImage("assets/next-play-fill.png"),
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
