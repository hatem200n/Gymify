import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymfiy/core/api/dio_provider.dart';
import 'package:gymfiy/core/api/end_points.dart';

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
          ? '$fillterType/$fillterValue/${EndPoints.exercises}'
          : 'exercises',
      queryParameters: {
        'offset': offset,
        'limit': limit,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>> fetchExercisesById(String id) async {
    final response = await _dio.get('exercises/$id');
    return response.data;
  }
}

final exerciseServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return ExerciseService(dio);
});
