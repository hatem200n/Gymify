import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gymfiy/core/model/exercise_model.dart';
import 'package:gymfiy/features/auth/presentation/providers/auth_provider.dart';
import 'package:gymfiy/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:gymfiy/features/home/presentation/screens/exercise_details_page.dart';
import 'package:gymfiy/features/home/presentation/screens/home_screen.dart';
import 'package:gymfiy/features/search/presentation/screens/search_page.dart';
import 'package:gymfiy/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:gymfiy/features/search/presentation/screens/search_results_page.dart';
import 'package:gymfiy/features/search/provider/serach_provider.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String exerciseDetailsPage = '/exerciseDetailsPage';
  static const String favoritesScreen = '/favoritesScreen';
  static const String searchPage = '/SearchPage';
  static const String searchResultsPage = '/searchResultsPage';
}

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen(authStateProvider, (_, __) => notifyListeners());
  }

  String? redirect(BuildContext context, GoRouterState state) {
    final authState = _ref.read(authStateProvider);
    final user = authState.value;
    final isOnboarding = state.matchedLocation == AppRoutes.onboarding;
    if (user == null) {
      if (!isOnboarding) return AppRoutes.onboarding;
      return null;
    }
    if (isOnboarding) return AppRoutes.home;
    return null;
  }
}

final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});

final goRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ref.read(routerNotifierProvider);

  return GoRouter(
    initialLocation: AppRoutes.onboarding,
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.favoritesScreen,
        builder: (context, state) => const FavoritesScreen(),
      ),
      GoRoute(
        path: AppRoutes.searchPage,
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
          path: AppRoutes.exerciseDetailsPage,
          builder: (context, state) {
            final exercise = state.extra as ExerciseModel;

            return ExerciseDetailsPage(
              exercise: exercise,
            );
          }),
      GoRoute(
          path: AppRoutes.searchResultsPage,
          builder: (context, state) {
            final filterArgs = state.extra as FilterArgs;
            return SearchResultsPage(
              filterArgs: filterArgs,
            );
          })
    ],
  );
});
