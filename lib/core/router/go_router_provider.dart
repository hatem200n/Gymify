import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gymfiy/core/local/storage_provider.dart';
import 'package:gymfiy/features/auth/presentation/providers/auth_provider.dart';
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

  RouterNotifier(this._ref) {
    // _ref.listen(hasViewedOnboardingProvider, (_, __) => notifyListeners());
    _ref.listen(authStateProvider, (_, __) => notifyListeners());
  }

  String? redirect(BuildContext context, GoRouterState state) {
    // 1. قراءة حالة الـ Auth الحالية من فايربيز
    final authState = _ref.read(authStateProvider);
    final user = authState.value; // لو null معناها مش مسجل

    final isOnboarding = state.matchedLocation == AppRoutes.onboarding;

    // المنطق اللي تبيه أنت بالظبط:

    // الحالة أ: المستخدم مش مسجل دخول (user == null)
    if (user == null) {
      // لو هو مش في الـ onboarding، ارفعه ليها بالسيف
      if (!isOnboarding) return AppRoutes.onboarding;

      // لو هو أصلاً في الـ onboarding، خليه مكانه
      return null;
    }

    // الحالة ب: المستخدم مسجل دخول (user != null)
    if (user != null) {
      // لو هو في الـ onboarding (صفحة البداية)، ارفعه للهوم طول
      if (isOnboarding) return AppRoutes.home;

      // لو في أي مكان ثاني، خليه براحته
      return null;
    }

    return null;
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
