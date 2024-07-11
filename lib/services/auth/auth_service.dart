import 'package:shalom_zen/services/auth/auth_provider.dart';
import 'package:shalom_zen/services/auth/auth_user.dart';
import 'package:shalom_zen/services/auth/firebase_auth.dart';

class AuthService implements AuthProvider {
  final AuthProvider authProvider;
  const AuthService(this.authProvider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());
  @override
  Future<AuthUser> createUser(
          {required String email, required String password}) =>
      authProvider.createUser(email: email, password: password);

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => authProvider.currentUser;

  @override
  Future<void> initialize() => authProvider.initialize();

  @override
  Future<AuthUser> logIn({required String email, required String password}) =>
      authProvider.logIn(email: email, password: password);

  @override
  Future<void> logOut() => authProvider.logOut();

  @override
  Future<void> deleteAccount() => authProvider.deleteAccount();

  @override
  Future<void> sendEmailVerification() => authProvider.sendEmailVerification();

  @override
  Future<void> sendPasswordReset({required String toEmail}) =>
      authProvider.sendPasswordReset(toEmail: toEmail);
}
