import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String kHasViewedOnboarding = 'hasViewedOnboarding';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences not initialized');
});

final hasViewedOnboardingProvider = FutureProvider<bool>((ref) async {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getBool(kHasViewedOnboarding) ?? false;
});

void setOnboardingViewed(WidgetRef ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  prefs.setBool(kHasViewedOnboarding, true);
}