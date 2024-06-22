import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shalom_zen/home/enums/tile_audio_source.dart';

class MusicTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String audioUrl;
  final TileAudioSource audioSource;
  final AudioPlayer audioPlayer;

  const MusicTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.audioUrl,
      required this.audioPlayer,
      required this.audioSource});

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
              ? audioPlayer.setAsset(audioUrl)
              : audioPlayer.setUrl(audioUrl),
          builder: (context, snapshot) {
            return Text(
              "${snapshot.data?.inMinutes.toString()} Mins",
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
