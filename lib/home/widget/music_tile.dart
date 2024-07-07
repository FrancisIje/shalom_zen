import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';

import 'package:shalom_zen/enums/tile_audio_source.dart';
import 'package:shalom_zen/player/sound_player.dart';

class MusicTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String audioUrl;
  final TileAudioSource audioSource;

  const MusicTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.audioUrl,
      required this.audioSource});

  @override
  Widget build(BuildContext context) {
    String formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "$twoDigitMinutes:$twoDigitSeconds";
    }

    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SoundPlayer(
              title: title,
              subtitle: subtitle,
              audioUrl: audioUrl,
              audioSource: audioSource),
        ));
      },
      leading: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/sound_image.jpeg"), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        width: 70,
        height: 65,
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: "Aeonik",
            color: Colors.white),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: "Aeonik",
            color: Colors.white.withOpacity(0.5)),
      ),
      trailing: FutureBuilder(
          future: audioSource == TileAudioSource.assets
              ? AudioPlayer().setAsset(audioUrl)
              : AudioPlayer().setUrl(audioUrl),
          builder: (context, snapshot) {
            return Text(
              formatDuration(snapshot.data ?? Duration.zero),
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Aeonik",
                  color: Colors.white),
            );
          }),
    );
  }
}
