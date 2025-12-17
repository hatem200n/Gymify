import 'package:gymfiy/core/model/exercise_model.dart';
import 'package:gymfiy/features/home/data/services/exercise_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ExerciseRepository {
  final ExerciseService _service;
  ExerciseRepository(this._service);

// في ملف exercise_repository.dart
  Future<List<ExerciseModel>> getAllExercises(
      {int offset = 0,
      int limit = 10,
      String? fillterType,
      String? fillterValue}) async {
    final response =
        await _service.fetchAllExercises(offset: offset, limit: limit);
    final List rawData = response['data'];
    return rawData.map((e) => ExerciseModel.fromJson(e)).toList();
  }
}

final exerciseRepositoryProvider = Provider((ref) {
  final service = ref.watch(exerciseServiceProvider);
  return ExerciseRepository(service);
});
