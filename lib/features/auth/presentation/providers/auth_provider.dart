import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';

// 1. بروفايدر للـ Firebase Instance
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// 2. بروفايدر للـ GoogleSignIn Instance
final googleSignInProvider = Provider<GoogleSignIn>((ref) => GoogleSignIn());

// 3. بروفايدر للـ Repository (نربطوا الـ Contract بالـ Implementation)
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  final google = ref.watch(googleSignInProvider);
  return AuthRepositoryImpl(auth, google);
});

// 4. بروفايدر لمراقبة حالة المستخدم (هل هو مسجل دخول أو لا)
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});