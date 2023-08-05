import 'package:flutter_my_app/repositories/user/models/auth_user.dart';

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

  Future<AuthUser> getUser(String id);
}