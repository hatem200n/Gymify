import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential> signUpWithEmail(String email, String password);

  Future<UserCredential> signInWithEmail(String email, String password);

  Future<UserCredential> signInWithGoogle();

  Future<void> signOut();

  Stream<User?> get authStateChanges;
}
