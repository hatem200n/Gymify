import 'package:gymfiy/core/model/exercise_model.dart';
import 'package:gymfiy/features/home/data/services/exercise_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ExerciseRepository {
  final ExerciseService _service;
  ExerciseRepository(this._service);

  Future<List<ExerciseModel>> getAllExercises({
    int offset = 0,
    int limit = 10,
    String? fillterType,
    String? fillterValue,
    String? search,
    List<String>? muscles,
    List<String>? equipments,
    List<String>? bodyParts,
    String? sortBy,
    String? sortOrder,
  }) async {
    final response = await _service.fetchAllExercises(
      offset: offset,
      limit: limit,
      fillterType: fillterType,
      fillterValue: fillterValue,
    );
    final List rawData = response['data'];
    return rawData.map((e) => ExerciseModel.fromJson(e)).toList();
  }

  Future<ExerciseModel> fetchExerciseById(String id) async {
    final response = await _service.fetchExercisesById(id);
    final rawData = response['data'];
    return ExerciseModel.fromJson(rawData);
  }
}

final exerciseRepositoryProvider = Provider((ref) {
  final service = ref.watch(exerciseServiceProvider);
  return ExerciseRepository(service);
});
