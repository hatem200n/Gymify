import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymfiy/core/api/dio_provider.dart';
import 'package:gymfiy/core/api/end_points.dart';

class SearchService {
  final Dio _dio;
  SearchService(this._dio);

  Future<Map<String, dynamic>> fetchAllSearchedExercises({
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
    final queryParams = {
      'offset': offset,
      'limit': limit,
      if (search != null) 'search': search,
      if (muscles != null && muscles.isNotEmpty) 'muscles': muscles.join(','),
      if (equipments != null && equipments.isNotEmpty)
        'equipments': equipments.join(','),
      if (bodyParts != null && bodyParts.isNotEmpty)
        'bodyParts': bodyParts.join(','),
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
    };

    final response =
        await _dio.get(EndPoints.search, queryParameters: queryParams);
    return response.data;
  }
}

final searchServiceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return SearchService(dio);
});
