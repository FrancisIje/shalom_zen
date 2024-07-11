import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shalom_zen/models/user_model.dart';
import 'package:shalom_zen/models/user_recordings.dart';
import 'package:shalom_zen/services/database/database_provider.dart';

class FirestoreProvider implements DatabaseProvider {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  final uid = FirebaseAuth.instance.currentUser?.uid ?? "";

  @override
  Future<void> createUser({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    await _users.doc(uid).set(ZenUser(
          id: uid,
          firstName: firstName,
          lastName: lastName,
          email: email,
          profileUrl: null,
          password: password,
        ).toFirestore());
  }

  @override
  Future<ZenUser> getUser() async {
    final DocumentSnapshot snapshot = await _users.doc(uid).get();

    if (snapshot.exists) {
      return ZenUser.fromFirestore(snapshot.data()! as Map<String, dynamic>);
    } else {
      throw Exception('User not found');
    }
  }

  @override
  Future<void> updateUser(
      {String? firstName, String? lastName, String? profileUrl}) async {
    try {
      final DocumentReference userRef = _users.doc(uid);

      final Map<String, dynamic> updateData = {};
      if (firstName != null && firstName.isNotEmpty) {
        updateData[ZenUserConst.firstName] = firstName;
      }
      if (lastName != null && lastName.isNotEmpty) {
        updateData[ZenUserConst.lastName] = lastName;
      }
      if (profileUrl != null && profileUrl.isNotEmpty) {
        updateData[ZenUserConst.profileUrl] = profileUrl;
      }

      await userRef.update(updateData);
    } on FirebaseException {
      rethrow;
    }
  }

  @override
  Future<void> deleteUser() async {
    await _users.doc(uid).delete();
  }

  @override
  Future<void> addRecording(UserRecordings rec) async {
    // TODO: implement addRecording
    await _users
        .doc(uid)
        .collection(ZenUserConst.userRecordings)
        .add(rec.toMap());
  }

  @override
  Future<void> removeRecording(String recUrl) async {
    // TODO: implement removeRecording
    final recordDetails = await _users
        .doc(uid)
        .collection(ZenUserConst.userRecordings)
        .where(RecordingConst.downloadUrl, isEqualTo: recUrl)
        .get();
    final recId = recordDetails.docs.first.id;
    await _users
        .doc(uid)
        .collection(ZenUserConst.userRecordings)
        .doc(recId)
        .delete();
  }

  @override
  Stream<List<UserRecordings>> getRecordingsStream() {
    return _users
        .doc(uid)
        .collection(ZenUserConst.userRecordings)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserRecordings.fromMap(doc.data()))
            .toList());
  }
}
