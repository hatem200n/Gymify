import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gymfiy/core/local/storage_provider.dart';
import 'package:gymfiy/features/auth/presentation/screens/login_sheet.dart';
import 'package:gymfiy/features/home/presentation/screens/home_screen.dart';
import 'package:gymfiy/features/onboarding/presentation/screens/onboarding_screen.dart';

// 1. تعريف الـ Paths (عشان ما نغلطوش في كتابة الروابط)
class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String home = '/home'; // حنغيروها بعدين
  static const String login = '/login';
}

// 2. الـ Notifier اللي حيقرر وين يمشي المستخدم
class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  bool _hasViewedOnboarding = false;
  bool _isLoading = true;

  RouterNotifier(this._ref) {
    // 💡 نستخدم ref.listen باش نتابعوا حالة الـ Caching
    _ref.listen(hasViewedOnboardingProvider, (_, next) {
      next.when(
        data: (hasViewed) {
          _hasViewedOnboarding = hasViewed;
          _isLoading = false;
          // 💡 هذا هو مفتاح التحديث: نقولو لـ GoRouter راهو صار تغيير!
          notifyListeners();
        },
        loading: () {
          _isLoading = true;
          notifyListeners();
        },
        error: (err, stack) {
          _isLoading = false;
          notifyListeners();
        },
      );
    });
  }
  String? redirect(BuildContext context, GoRouterState state) {
    if (_isLoading) return null;
//TODO make != ==
    final isOnboarding = state.matchedLocation != AppRoutes.onboarding;

    if (_hasViewedOnboarding) {
      return isOnboarding ? AppRoutes.home : null;
    } else {
      return isOnboarding ? null : AppRoutes.onboarding;
    }
  }
}

final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});

final goRouterProvider = Provider<GoRouter>((ref) {
  // 💡 نستخدم read عشان ما نديروش rebuild لكل GoRouter
  final notifier = ref.read(routerNotifierProvider);

  return GoRouter(
    initialLocation: AppRoutes.onboarding,
    // هذا يحتاج كلاس يورث من Listenable (وهذا هو RouterNotifier)
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
      // GoRoute(
      //   path: AppRoutes.login,
      //   builder: (context, state) => const Login(),
      // )
    ],
  );
});
