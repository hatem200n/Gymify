import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymfiy/core/model/explore_item.dart';
import 'package:gymfiy/core/theme/app_colors.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';
import 'package:gymfiy/features/home/presentation/screens/filltred_exercises.dart';

class ExploerListCard extends StatelessWidget {
  final ExploreItem item;
  final String fillterType;
  const ExploerListCard(
      {super.key, required this.item, required this.fillterType});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FilltredExercises(
                background: item.image,
                fillterType: fillterType,
                fillterValue: item.name),
          )),
      child: Hero(
        tag: item.name,
        child: Container(
          width: 300.w,
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(20.r),
                  child: Image.asset(
                    item.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                  width: 300.w,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          end: Alignment.centerRight,
                          begin: Alignment.centerLeft,
                          colors: [
                            AppColors.primary.withValues(alpha: 0.7),
                            AppColors.primary.withValues(alpha: 0.4),
                            AppColors.primary.withValues(alpha: 0.2),
                          ]),
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      item.name.makeLabelText(context,
                          fontSize: 40, color: AppColors.lightBackground),
                      item.description.makeLabelText(context,
                          fontSize: 12,
                          color: AppColors.lightBackground,
                          maxLines: 3),
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.secondary.withValues(alpha: 0.7),
                    ),
                    child: item.duration.makeBodyText(
                      context,
                      fontSize: 12,
                      color: AppColors.lightBackground,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
