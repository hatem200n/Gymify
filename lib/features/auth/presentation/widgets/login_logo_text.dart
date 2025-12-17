import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymfiy/core/theme/app_colors.dart';

class LoginLoginLogoText extends StatelessWidget {
  const LoginLoginLogoText({
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
                fontSize: 100.sp,
                letterSpacing: 6,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.oswald().fontFamily),
          ),
          TextSpan(
            text: 'FY',
            style: theme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontSize: 70.sp,
                letterSpacing: 6,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.oswald().fontFamily),
          ),
        ],
      ),
    );
  }
}
