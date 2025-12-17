import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymfiy/core/model/exercise_model.dart';
import 'package:gymfiy/features/home/data/Repository/exercise_repository.dart';

class ExercisesNotifier extends AsyncNotifier<List<ExerciseModel>> {
  int _offset = 0;
  final int _limit = 10;
  bool _hasMore = true;

  @override
  Future<List<ExerciseModel>> build() async {
    return _fetchInitial();
  }

  Future<List<ExerciseModel>> _fetchInitial() async {
    _offset = 0; // ريست للأوفست
    final repo = ref.read(exerciseRepositoryProvider);
    return await repo.getAllExercises(offset: _offset, limit: _limit);
  }

  Future<void> fetchMore() async {
    // لو قاعد يحمل أو مفيش داتا زيادة، ما تدير شي
    if (state.isLoading || !_hasMore) return;

    final oldData = state.value ?? [];

    // نخلوا الحالة السابقة موجودة بس نزيدوا عليها علامة التحميل (اختياري)
    // state = AsyncLoading<List<ExerciseModel>>().copyWithPrevious(state);

    try {
      _offset += _limit;
      final repo = ref.read(exerciseRepositoryProvider);
      final newData =
          await repo.getAllExercises(offset: _offset, limit: _limit);

      if (newData.isEmpty) {
        _hasMore = false;
      } else {
        state = AsyncData([...oldData, ...newData]);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final exercisesNotifierProvider =
    AsyncNotifierProvider<ExercisesNotifier, List<ExerciseModel>>(() {
  return ExercisesNotifier();
});
