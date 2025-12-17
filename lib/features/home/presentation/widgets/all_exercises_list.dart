import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymfiy/core/model/exercise_model.dart';
import 'package:gymfiy/core/theme/app_colors.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';
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
    final state = ref.watch(exercisesNotifierProvider);

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
              itemCount: items.length + (state.isLoading ? 1 : 0),
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

  // سكيلتون لـ 3 كروت كبداية
  Widget _buildSkeleton(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: List.generate(
            3,
            (index) =>
                // كرت وهمي باش Skeletonizer يعرف الشكل
                Container(
                    height: 220.h,
                    margin: const EdgeInsets.all(10),
                    color: Colors.grey)),
      ),
    );
  }
}

class AllExercisesListCard extends StatelessWidget {
  final ExerciseModel item;

  const AllExercisesListCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.primary.withValues(alpha: 0.3),
      ),
      child: Stack(
        children: [
          // 🖼️ Exercise GIF
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.network(
                item.gifUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.fitness_center)),
              ),
            ),
          ),

          // 🌫️ Gradient overlay
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.8),
                    Colors.black.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🏋️ Name
                  item.name.makeLabelText(
                    context,
                    fontSize: 18,
                    color: Colors.white,
                  ),

                  4.verticalSpace,

                  // 🎯 Target muscle
                  _Tag(
                    text: item.targetMuscles.firstOrNull ?? 'Unknown',
                  ),

                  6.verticalSpace,

                  // 💪 Secondary muscles
                  Wrap(
                    spacing: 6,
                    children: item.secondaryMuscles
                        .take(3)
                        .map((m) => _Tag(text: m, small: true))
                        .toList(),
                  ),

                  6.verticalSpace,

                  // 📝 Short description (instruction)
                  if (item.instructions.isNotEmpty)
                    item.instructions.first
                        .replaceAll('Step:1', '')
                        .makeBodyText(
                          context,
                          fontSize: 12,
                          color: Colors.white70,
                          maxLines: 2,
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  final bool small;

  const _Tag({
    required this.text,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 6.w : 10.w,
        vertical: small ? 2.h : 4.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: small ? 10.sp : 12.sp,
        ),
      ),
    );
  }
}
