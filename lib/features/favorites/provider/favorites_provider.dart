import 'package:gymfiy/core/model/exercise_model.dart';
import 'package:gymfiy/core/providers/favorites_notifier.dart';
import 'package:gymfiy/features/home/data/Repository/exercise_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final favoriteExercisesProvider =
    FutureProvider<List<ExerciseModel>>((ref) async {
  final favoriteIds = ref.watch(favoritesProvider);

  if (favoriteIds.isEmpty) return [];

  final repo = ref.read(exerciseRepositoryProvider);

  final exercises = await Future.wait(
    favoriteIds.map((id) => repo.fetchExerciseById(id)),
  );

  return exercises;
});
