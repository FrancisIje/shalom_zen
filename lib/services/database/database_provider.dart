import 'package:shalom_zen/models/user_model.dart';

abstract class DatabaseProvider {
  Future<void> createUser(
      {required String email,
      required String firstName,
      required String lastName,
      required String password});
}
