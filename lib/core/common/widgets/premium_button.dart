import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymfiy/core/theme/app_colors.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';

class PremiumButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? width;
  final bool isDisabled;

  const PremiumButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    // 💡 نحدد اللون الأساسي والـ Opacity حسب الحالة
    final color = isDisabled
        ? AppColors.hintText.withValues(alpha: 0.5)
        : AppColors.primary;

    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width - 30.w,
      height: 50,
      child: ElevatedButton(
        onPressed: (isLoading || isDisabled) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        child: isLoading
            ? const Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                ),
              )
            : text.makeTitleText(
                context,
                color: Colors.white,
                bold: true,
              ),
      ),
    );
  }
}
