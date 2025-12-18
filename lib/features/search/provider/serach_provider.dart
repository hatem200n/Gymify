import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymfiy/core/model/exercise_model.dart';
import 'package:gymfiy/features/search/data/repo/search_repository.dart';

typedef FilterArgs = ({
  String? search,
  List<String>? muscles,
  List<String>? equipments,
  List<String>? bodyParts,
  String? sortBy,
  String? sortOrder,
});

class SearchExercisesNotifier
    extends FamilyAsyncNotifier<List<ExerciseModel>, FilterArgs> {
  int _offset = 0;
  final int _limit = 10;
  bool _hasMore = true;

  @override
  Future<List<ExerciseModel>> build(FilterArgs arg) async {
    _offset = 0;
    _hasMore = true;
    return _fetch(arg);
  }

  Future<List<ExerciseModel>> _fetch(FilterArgs arg) async {
    final repo = ref.read(searchRepositoryProvider);

    return repo.fetchAllSearchedExercises(
      offset: _offset,
      limit: _limit,
      search: arg.search,
      muscles: arg.muscles,
      equipments: arg.equipments,
      bodyParts: arg.bodyParts,
      sortBy: arg.sortBy,
      sortOrder: arg.sortOrder,
    );
  }

  Future<void> fetchMore() async {
    final arg = this.arg;
    if (state.isLoading || !_hasMore) return;

    _offset += _limit;
    final repo = ref.read(searchRepositoryProvider);
    final newData = await repo.fetchAllSearchedExercises(
      offset: _offset,
      limit: _limit,
      search: arg.search,
      muscles: arg.muscles,
      equipments: arg.equipments,
      bodyParts: arg.bodyParts,
      sortBy: arg.sortBy,
      sortOrder: arg.sortOrder,
    );

    if (newData.isEmpty) {
      _hasMore = false;
    } else {
      final oldData = state.value ?? [];
      state = AsyncData([...oldData, ...newData]);
    }
  }
}

final searchExercisesProvider = AsyncNotifierProviderFamily<
    SearchExercisesNotifier, List<ExerciseModel>, FilterArgs>(
  () => SearchExercisesNotifier(),
);
