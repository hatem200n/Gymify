import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gymfiy/core/model/exercise_model.dart';
import 'package:gymfiy/core/router/go_router_provider.dart';
import 'package:gymfiy/core/theme/app_colors.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';

class AllExercisesListCard extends StatelessWidget {
  final ExerciseModel item;

  const AllExercisesListCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          GoRouter.of(context).push(AppRoutes.exerciseDetailsPage, extra: item),
      child: Container(
        height: 200.h,
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.primary.withValues(alpha: 0.3),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: CachedNetworkImage(
                  imageUrl: item.gifUrl,
                  fit: BoxFit.cover,
                  errorWidget: (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.fitness_center)),
                ),
              ),
            ),
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
                    item.name.makeLabelText(
                      context,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    4.verticalSpace,
                    _buildTag(item.targetMuscles.firstOrNull ?? 'Unknown',
                        false, context),
                    6.verticalSpace,
                    Wrap(
                      spacing: 6,
                      children: item.secondaryMuscles
                          .take(3)
                          .map((m) => _buildTag(m, true, context))
                          .toList(),
                    ),
                    6.verticalSpace,
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
      ),
    );
  }

  Widget _buildTag(String text, bool small, BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: small ? 6.w : 10.w,
          vertical: small ? 2.h : 4.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.secondary.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: text.makeLabelText(context, color: Colors.white));
  }
}
