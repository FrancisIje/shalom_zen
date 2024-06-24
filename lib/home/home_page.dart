import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shalom_zen/enums/tile_audio_source.dart';
import 'package:shalom_zen/player/sound_player.dart';

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
                      Expanded(child: const Gap(2)),
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
                          Expanded(child: const Gap(16)),
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
                onTap: () {},
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
                      Expanded(child: const Gap(2)),
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
          Text(
            "Browse Recordings",
            style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w500,
                fontFamily: "Aeonik",
                color: Colors.white),
          ),
          Gap(16),
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/sound_image.jpeg"),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              width: 70,
              height: 65,
            ),
            title: Text(
              "Recording 1",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Aeonik",
                  color: Colors.white),
            ),
            subtitle: Text(
              "Mantra",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Aeonik",
                  color: Colors.white.withOpacity(0.5)),
            ),
            trailing: Text(
              "10 Mins",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Aeonik",
                  color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
