import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/local/hive_provider.dart';
import 'core/local/storage_provider.dart';
import 'core/router/go_router_provider.dart';
// import 'firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. تهيئة SharedPreferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // تهيئة Hive
  await initHive();

  // تهيئة Firebase
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ProviderScope(
      // 2. تمرير الـ instance بتاع SharedPreferences
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const Gymfiy(),
    ),
  );
}

class Gymfiy extends ConsumerWidget {
  const Gymfiy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. استدعاء GoRouter
    final router = ref.watch(goRouterProvider);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context,child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system,
        
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          routerDelegate: router.routerDelegate,
        );
      }
    );
  }
}
