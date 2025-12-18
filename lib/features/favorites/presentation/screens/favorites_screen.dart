import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymfiy/core/errors/error_retry_view.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';
import 'package:gymfiy/features/favorites/provider/favorites_provider.dart';
import 'package:gymfiy/features/home/presentation/widgets/all-exrciecs-section/all_exercises_list_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoriteExercisesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: favoritesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorRetryView(
            message: e.toString(),
            onRetry: () {
              ref.invalidate(favoriteExercisesProvider);
            }),
        data: (exercises) {
          if (exercises.isEmpty) {
            return const _EmptyFavoritesView();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: exercises.length,
            itemBuilder: (_, i) => AllExercisesListCard(item: exercises[i]),
          );
        },
      ),
    );
  }
}

class _EmptyFavoritesView extends StatelessWidget {
  const _EmptyFavoritesView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite_border, size: 64),
          16.verticalSpace,
          "No favorite exercises yet".makeBodyText(context),
        ],
      ),
    );
  }
}
