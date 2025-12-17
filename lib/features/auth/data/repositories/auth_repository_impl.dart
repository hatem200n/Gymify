import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl(this._auth, this._googleSignIn);

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      // 1. عملية الدخول فقط
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // 2. تشيك لو الـ user موجود بطريقة آمنة
      final user = credential.user;
      if (user != null) {
        final String username = user.email?.split('@')[0] ?? "User";

        // 3. التخزين في الكاش (خارج الـ try الأساسية لو تبي تضمن)
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_name', username);
        print("✅ الاسم المخزن: $username");
      }

      return credential;
    } catch (e) {
      print('❌ Error in signIn: $e');
      rethrow;
    }
  }

  @override
  Future<UserCredential> signUpWithEmail(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (credential.user != null) {
      // 💡 استخراج الاسم من الإيميل (كل شي قبل الـ @)
      final String username = email.split('@')[0];

      // 💡 تخزين الاسم في الكاش
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', username);
      await prefs.setBool('is_logged_in', true); // علامة إن المستخدم سجل دخول
    }
    return credential;
  }

  @override
  @override
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) throw Exception('Sign in aborted by user');

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // 1. تسجيل الدخول في فايربيز
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    return userCredential;
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear().then(
          (value) => print("signed out $value"),
        );
  }
}
