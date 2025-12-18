import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymfiy/features/auth/presentation/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefsProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

final userNameProvider = Provider<String>((ref) {
  ref.watch(authStateProvider);

  final prefsAsync = ref.watch(sharedPrefsProvider);

  return prefsAsync.maybeWhen(
    data: (prefs) => prefs.getString('user_name') ?? "Coauch",
    orElse: () => "Coauch",
  );
});
