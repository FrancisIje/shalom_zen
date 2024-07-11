import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shalom_zen/enums/tile_audio_source.dart';
import 'package:shalom_zen/home/record_page.dart';
import 'package:shalom_zen/home/widget/music_tile.dart';
import 'package:shalom_zen/models/user_recordings.dart';
import 'package:shalom_zen/player/sound_player.dart';
import 'package:shalom_zen/services/database/firebase_cloud_database.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Gap(16),
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white.withOpacity(0.2),
              ),
              hintText: "Search",
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.2),
              ),

              filled: true, // Enable background fill
              fillColor:
                  Colors.white.withOpacity(0.15), // Set transparent background
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
                borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0.0), // Remove border outline
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
                borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0.0), // Remove border outline
              ),
            ),
          ),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SoundPlayer(
                        title: "528 Hz",
                        subtitle: "Relax Frequency",
                        audioUrl: "assets/Manifest_Your_Greatness_528hz.mp3",
                        audioSource: TileAudioSource.assets),
                  ));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.44,
                  height: 200,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: const BoxDecoration(
                      color: Color(0xFFD7F7A2),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Pure Hz to Relax",
                        style: TextStyle(
                            fontFamily: "Aeonik",
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: Color(0xFF0D1915)),
                      ),
                      const Expanded(child: Gap(2)),
                      Row(
                        children: [
                          const Text(
                            "Listen now",
                            style: TextStyle(
                                fontFamily: "Aeonik",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          const Expanded(child: Gap(16)),
                          Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width * 0.1,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF0D191526)
                                      .withOpacity(0.15)),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RecordPage(),
                  ));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.44,
                  height: 200,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Record \nMantra",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: "Aeonik",
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                      const Expanded(child: Gap(2)),
                      Row(
                        children: [
                          const Text(
                            "Start recording",
                            style: TextStyle(
                                fontFamily: "Aeonik",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          const Expanded(child: Gap(4)),
                          const Gap(16),
                          Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width * 0.1,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: const Icon(Icons.mic))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
          const Text(
            "Browse Recordings",
            style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w500,
                fontFamily: "Aeonik",
                color: Colors.white),
          ),
          const Gap(16),
          StreamBuilder(
            stream: FirestoreProvider().getRecordingsStream(),
            builder: (context, snapshot) {
              List<UserRecordings> recordings = snapshot.data ?? [];
              return Expanded(
                child: ListView.builder(
                  itemCount: recordings.length,
                  itemBuilder: (context, index) {
                    var eachRecording = recordings[index];
                    return MusicTile(
                        title: eachRecording.title,
                        subtitle: "Mantra",
                        audioUrl: eachRecording.downnloadUrl,
                        audioSource: TileAudioSource.url);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
