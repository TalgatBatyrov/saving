import 'models/auth_user.dart';

abstract class AbstractAuthRepository {
  Future<void> signIn({
    required String email,
    required String password,
  });
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<void> signOut();

  // send email verification
  Future<void> sendEmailVerification();

  Future<AuthUser> getUser(String id);
}
