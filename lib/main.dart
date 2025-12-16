import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/local/hive_provider.dart';
// import 'firebase_options.dart'; // لما تربط الفايربيس
// import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Firebase [cite: 31]
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // تهيئة Hive
  await initHive();

  runApp(
    // ⚠️ هذا هو الـ Scope اللي يخلي Riverpod يخدم في التطبيق كله
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // هنا حنربطوا الـ Theme والـ Router بعدين
    return MaterialApp(
      title: 'Artisans Fit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), // مبدئياً
      darkTheme: ThemeData.dark(), //
      themeMode: ThemeMode.system,
      home: const Scaffold(
        body: Center(child: Text('يا طير، المشروع بدى يخدم! 🚀')),
      ),
    );
  }
}
