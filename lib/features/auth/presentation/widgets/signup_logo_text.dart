import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymfiy/core/theme/app_colors.dart';

class SignupLogoText extends StatelessWidget {
  const SignupLogoText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'GYMI',
            style: theme.titleLarge?.copyWith(
                fontSize: 80.sp,
                letterSpacing: 6,
                color: AppColors.lightBackground,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.oswald().fontFamily),
          ),
          TextSpan(
            text: 'FY',
            style: theme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontSize: 50.sp,
                letterSpacing: 6,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.oswald().fontFamily),
          ),
        ],
      ),
    );
  }
}
