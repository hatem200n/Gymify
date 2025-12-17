import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymfiy/features/auth/presentation/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 1. بروفايدر يجيب الـ Instance بطريقة Async آمنة
final sharedPrefsProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

// 2. بروفايدر الاسم (يستخدم watch للـ FutureProvider)
final userNameProvider = Provider<String>((ref) {
  // 💡 اللقطة السحرية: نراقبوا حالة الـ Auth
  // أول ما يتغير المستخدم (تسجيل خروج أو دخول)، البروفايدر هذا حيتحدث تلقائياً
  ref.watch(authStateProvider);

  final prefsAsync = ref.watch(sharedPrefsProvider);

  return prefsAsync.maybeWhen(
    data: (prefs) => prefs.getString('user_name') ?? "كابتن",
    orElse: () => "كابتن",
  );
});
