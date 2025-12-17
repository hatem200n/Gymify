import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymfiy/core/theme/app_colors.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';

class HomePageBanner extends StatelessWidget {
  const HomePageBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      height: 230,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(20.r)),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20.r),
              child: Image.asset(
                "assets/images/banner-image2.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 40.w),
              width: double.infinity,
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
                children: [
                  "+150".makeLabelText(context,
                      fontSize: 40, color: AppColors.lightBackground),
                  "exercises for different\n muscle".makeBodyText(context,
                      fontSize: 20, color: AppColors.lightBackground),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.lightBackground,
                    ),
                    child: Row(
                      spacing: 5.r,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        "expoler now".makeLabelText(context,
                            color: AppColors.darkBackground),
                        Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: AppColors.lightBackground,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

