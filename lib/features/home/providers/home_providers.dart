import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymfiy/core/model/exercise_model.dart';
import 'package:gymfiy/features/home/data/Repository/exercise_repository.dart';

typedef FilterArgs = ({String? type, String? value});

class FilteredExercisesNotifier
    extends FamilyAsyncNotifier<List<ExerciseModel>, FilterArgs?> {
  int _offset = 0;
  final int _limit = 10;
  bool hasMore = true;

  @override
  Future<List<ExerciseModel>> build(FilterArgs? arg) async {
    return _fetchInitial(arg);
  }

  Future<List<ExerciseModel>> _fetchInitial(FilterArgs? arg) async {
    _offset = 0;
    hasMore = true;
    final repo = ref.read(exerciseRepositoryProvider);
    return await repo.getAllExercises(
      offset: _offset,
      limit: _limit,
      fillterType: arg?.type,
      fillterValue: arg?.value,
    );
  }

  Future<void> refresh() async {
    final currentArgs = arg;

    state = const AsyncLoading();

    try {
      _offset = 0;
      hasMore = true;

      final repo = ref.read(exerciseRepositoryProvider);
      final data = await repo.getAllExercises(
        offset: _offset,
        limit: _limit,
        fillterType: currentArgs?.type,
        fillterValue: currentArgs?.value,
      );

      state = AsyncData(data);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> fetchMore() async {
    if (state.isLoading || !hasMore) return;

    final currentArgs = arg;

    try {
      _offset += _limit;
      final repo = ref.read(exerciseRepositoryProvider);
      final newData = await repo.getAllExercises(
        offset: _offset,
        limit: _limit,
        fillterType: currentArgs?.type,
        fillterValue: currentArgs?.value,
      );

      if (newData.isEmpty) {
        hasMore = false;
      } else {
        final oldData = state.value ?? [];
        state = AsyncData([...oldData, ...newData]);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final exercisesNotifierProvider = AsyncNotifierProviderFamily<
    FilteredExercisesNotifier, List<ExerciseModel>, FilterArgs?>(
  () => FilteredExercisesNotifier(),
);
final filteredExercisesProvider = exercisesNotifierProvider;
