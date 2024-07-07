import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shalom_zen/services/storage/storage_provider.dart';

class AppFirebaseStorage implements StorageProvider {
  @override
  Future<void> deleteFile(String filePath) async {
    await FirebaseStorage.instance.ref(filePath).delete();
  }

  @override
  Future<String> uploadFile(File file) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    String dateTimeString = DateTime.now().toString();
    await FirebaseStorage.instance
        .ref("users_upload")
        .child(userId)
        .child(dateTimeString)
        .putFile(file);
    final downloadUrl = await FirebaseStorage.instance
        .ref("users_upload")
        .child(userId)
        .child(dateTimeString)
        .getDownloadURL();
    return downloadUrl;
  }
}
