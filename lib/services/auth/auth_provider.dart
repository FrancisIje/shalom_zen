import 'package:shalom_zen/services/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  AuthUser? get currentUser;
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> deleteAccount();
  Future<void> sendEmailVerification();
  Future<void> sendPasswordReset({required String toEmail});
}
