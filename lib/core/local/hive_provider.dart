import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

// provider for open box
final hiveBoxProvider = Provider<Box>((ref) {
  throw UnimplementedError('Hive box not initialized yet');
});

//TODO we should call it in main
Future<void> initHive() async {
  await Hive.initFlutter();
  // لو عندك Custom Objects لازم تدير RegisterAdapter هنا
  // await Hive.openBox('settings'); // مثال
}
