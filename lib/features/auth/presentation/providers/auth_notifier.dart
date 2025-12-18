import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class AuthNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(authRepositoryProvider).signInWithGoogle());
  }

  Future<void> signUp(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
        ref.read(authRepositoryProvider).signUpWithEmail(email, password));
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
        ref.read(authRepositoryProvider).signInWithEmail(email, password));
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(authRepositoryProvider).signOut());
  }
}

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, void>(() {
  return AuthNotifier();
});
