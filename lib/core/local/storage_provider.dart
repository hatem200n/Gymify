import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 1. بروفايدر يجيب الـ Instance بطريقة Async آمنة
final sharedPrefsProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

// 2. بروفايدر الاسم (يستخدم watch للـ FutureProvider)
final userNameProvider = Provider<String>((ref) {
  // نقروا الحالة الحالية للـ SharedPreferences
  final prefsAsync = ref.watch(sharedPrefsProvider);
  
  // لو الداتا جت، اقرأ الاسم، لو مازال، رجع "كابتن"
  return prefsAsync.maybeWhen(
    data: (prefs) => prefs.getString('user_name') ?? "كابتن",
    orElse: () => "كابتن",
  );
});