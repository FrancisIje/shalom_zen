import 'package:shalom_zen/models/user_model.dart';
import 'package:shalom_zen/models/user_recordings.dart';

abstract class DatabaseProvider {
  Future<void> createUser(
      {required String email,
      required String firstName,
      required String lastName,
      required String password});
  Future<ZenUser> getUser();
  Future<void> updateUser();
  Future<void> deleteUser();
  Future<void> addRecording(UserRecordings rec);
  Future<void> removeRecording(String recUrl);
  Stream<List<UserRecordings>> getRecordingsStream();
}
