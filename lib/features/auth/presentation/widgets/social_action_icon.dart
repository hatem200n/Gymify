
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymfiy/core/theme/app_colors.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';

class SocialActionIcon extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;
  final bool isLoading;

  const SocialActionIcon({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Column(
        children: [
          Container(
            height: 40.h,
            padding: EdgeInsets.all(3.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200.r),
              border: Border.all(color: AppColors.secondaryText),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 30, child: CircularProgressIndicator(strokeWidth: 2))
                : Image.asset(icon),
          ),
          label.makeBodyText(context)
        ],
      ),
    );
  }
}
