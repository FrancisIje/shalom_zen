import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shalom_zen/models/user_model.dart';
import 'package:shalom_zen/services/database/database_provider.dart';

class FirestoreProvider implements DatabaseProvider {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  final uid = FirebaseAuth.instance.currentUser!.uid;

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
        password: password));
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
    final DocumentReference userRef = _users.doc(uid);

    final Map<String, dynamic> updateData = {};
    if (firstName != null) updateData['firstName'] = firstName;
    if (lastName != null) updateData['lastName'] = lastName;
    if (profileUrl != null) updateData['profileUrl'] = profileUrl;

    await userRef.update(updateData);
  }

  @override
  Future<void> deleteUser() async {
    await _users.doc(uid).delete();
  }
}
