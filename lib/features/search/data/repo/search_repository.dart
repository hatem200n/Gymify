import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymfiy/core/model/exercise_model.dart';
import 'package:gymfiy/features/search/data/services/search_service.dart';

class SearchRepository {
  final SearchService _service;
  SearchRepository(this._service);

  Future<List<ExerciseModel>> fetchAllSearchedExercises({
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
    final response = await _service.fetchAllSearchedExercises(
      offset: offset,
      limit: limit,
      fillterType: fillterType,
      fillterValue: fillterValue,
      search: search,
      muscles: muscles,
      equipments: equipments,
      bodyParts: bodyParts,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
    final List rawData = response['data'];
    return rawData.map((e) => ExerciseModel.fromJson(e)).toList();
  }
}

final searchRepositoryProvider = Provider((ref) {
  final service = ref.watch(searchServiceProvider);
  return SearchRepository(service);
});
