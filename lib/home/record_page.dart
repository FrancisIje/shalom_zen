import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:gap/gap.dart';
import 'package:record/record.dart';
import 'package:shalom_zen/global.dart';
import 'package:shalom_zen/models/user_recordings.dart';
import 'package:shalom_zen/services/database/firebase_cloud_database.dart';
import 'package:shalom_zen/services/storage/firebase_storage.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPage();
}

class _RecordPage extends State<RecordPage> {
  bool isRecording = false;
  String? recordingPath;
  Duration recordTimer = Duration.zero;
  late Timer timer;
  TextEditingController title = TextEditingController();

  void record() async {
    if (await appAudioRecorder.hasPermission()) {
      final Directory appDocumentDir = await getApplicationDocumentsDirectory();
      String filePath = p.join(appDocumentDir.path, "recording.wav");

      await appAudioRecorder.start(const RecordConfig(), path: filePath);

      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          setState(() {
            recordTimer = recordTimer + const Duration(seconds: 1);
            isRecording = true;
            recordingPath = null;
          });
        },
      );
    }
  }

  showTitleDialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Enter Name"),
              content: TextField(
                controller: title,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      final recordFile = File(recordingPath!);

                      try {
                        String downloadUrl =
                            await AppFirebaseStorage().uploadFile(recordFile);
                        final rec = UserRecordings(
                            title: title.text, downnloadUrl: downloadUrl);
                        FirestoreProvider().addRecording(rec).then(
                          (value) {
                            Fluttertoast.showToast(
                                msg: "Recording Uploaded",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.teal,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.of(context).pop();
                          },
                        ).onError(
                          (error, stackTrace) {
                            Fluttertoast.showToast(
                                msg: "Uploading Failed",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                        );
                      } catch (e) {
                        Fluttertoast.showToast(
                            msg: "Something went wrong!",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }

                      appAudioRecorder.dispose();
                      appAudioRecorder = AudioRecorder();
                    },
                    child: const Text("Upload"))
              ],
            ));
  }

  void stopRecorder() async {
    String? filePath = await appAudioRecorder.stop();
    isRecording = false;

    setState(() {
      recordingPath = filePath;
      recordTimer = Duration.zero;
      timer.cancel();
      print(recordingPath);
    });

    showTitleDialog();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    appAudioRecorder.stop();
    appAudioRecorder.dispose();
    title.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Image.asset(
                "assets/shalom_background4.png",
                fit: BoxFit.fill,
              )),
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            CupertinoIcons.back,
                            color: Colors.white,
                            size: 32,
                          ),
                        )),
                    Gap(appHeight * 0.10),
                    const Text(
                      "Record your Affirmations",
                      style: TextStyle(
                          fontFamily: "Aeonik",
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    Gap(appHeight * 0.1),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 16, color: const Color(0xFFD7F7A2)),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 112,
                          child: isRecording
                              ? Text(
                                  "${recordTimer.inSeconds.toString()} secs",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 32),
                                )
                              : const ImageIcon(
                                  AssetImage("assets/pulse.png"),
                                  color: Color(0xFFD7F7A2),
                                ),
                        ),
                      ),
                    ),
                    Gap(appHeight * 0.2),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 4, color: const Color(0xFFD7F7A2)),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 22,
                        child: isRecording
                            ? GestureDetector(
                                onTap: () => stopRecorder(),
                                child: const Icon(Icons.stop_rounded,
                                    color: Color(0xFFD7F7A2), size: 22),
                              ) // Timer icon
                            : GestureDetector(
                                onTap: () => record(),
                                child: const Icon(Icons.mic,
                                    color: Color(0xFFD7F7A2), size: 22),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
