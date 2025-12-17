import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  // تسجيل بالإيميل
  Future<UserCredential> signUpWithEmail(String email, String password);

  // دخول بالإيميل
  Future<UserCredential> signInWithEmail(String email, String password);

  // دخول بقوقل (صقع بكل)
  Future<UserCredential> signInWithGoogle();

  // تسجيل خروج
  Future<void> signOut();

  // مراقبة حالة المستخدم (خاش أو لا)
  Stream<User?> get authStateChanges;
}
