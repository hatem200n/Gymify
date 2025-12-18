import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';
import 'package:gymfiy/features/home/presentation/widgets/all-exrciecs-section/all_exercises_list_card.dart';
import 'package:gymfiy/features/home/providers/home_providers.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllExercisesList extends ConsumerWidget {
  final String title;
  final String? fillterType;
  final String? fillterValue;

  const AllExercisesList(
      {super.key, required this.title, this.fillterType, this.fillterValue});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(exercisesNotifierProvider(null));
    final provider = ref.watch(exercisesNotifierProvider(null).notifier);

    return state.when(
      loading: () => _buildSkeleton(context),
      error: (err, _) => Center(child: Text("خطأ: $err")),
      data: (items) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: title.makeTitleText(context),
            ),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length +
                  (state.isLoading
                      ? 1
                      : provider.hasMore
                          ? 1
                          : 0),
              itemBuilder: (context, index) {
                if (index < items.length) {
                  return AllExercisesListCard(item: items[index]);
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: List.generate(
            3,
            (index) => Container(
                height: 220.h,
                margin: const EdgeInsets.all(10),
                color: Colors.grey)),
      ),
    );
  }
}
