import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymfiy/core/api/dio_provider.dart';

class ExerciseService {
  final Dio _dio;
  ExerciseService(this._dio);

  Future<Map<String, dynamic>> fetchAllExercises(
      {int offset = 0,
      int limit = 10,
      String? fillterType,
      String? fillterValue}) async {
    final response = await _dio.get(
      fillterType != null
          ? '$fillterType/$fillterValue/exercises'
          : 'exercises',
      queryParameters: {
        'offset': offset,
        'limit': limit,
      },
    );
    return response.data;
  }
}

// Provider للخدمة
final exerciseServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider); // 💡 استخدمنا الـ dio بتاعك هنا
  return ExerciseService(dio);
});
