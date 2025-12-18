import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesNotifier extends StateNotifier<Set<String>> {
  static const _key = 'favorite_exercises';

  FavoritesNotifier() : super({}) {
    _loadFromCache();
  }

  bool isFavorite(String id) => state.contains(id);

  void toggleFavorite(String id) {
    final newState = {...state};

    if (newState.contains(id)) {
      newState.remove(id);
    } else {
      newState.add(id);
    }

    state = newState;
    _saveToCache();
  }

  Future<void> _saveToCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, state.toList());
  }

  Future<void> _loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_key) ?? [];
    state = ids.toSet();
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<String>>(
  (ref) => FavoritesNotifier(),
);
