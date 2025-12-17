import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromARGB(255, 0, 60, 191); 
  static const Color secondary = Color(0xFFFF9800);

  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF121212);

  static const Color primaryText = Color(0xFF212121);
  static const Color secondaryText = Color(0xFF757575);
  static const Color hintText = Color(0xFFAAAAAA);
  static const Color error = Color(0xFFD32F2F);
}

class ThemeColors {
  final Color primary;
  final Color background;
  final Color text;
  final Color hint;
  final Color error;

  const ThemeColors({
    required this.primary,
    required this.background,
    required this.text,
    required this.hint,
    required this.error,
  });

  static const light = ThemeColors(
    primary: AppColors.primary,
    background: AppColors.lightBackground,
    text: AppColors.primaryText,
    hint: AppColors.hintText,
    error: AppColors.error,
  );

  static const dark = ThemeColors(
    primary: AppColors.primary,
    background: AppColors.darkBackground,
    text: Color(0xFFFFFFFF),
    hint: Color(0xFFBBBBBB),
    error: AppColors.error,
  );
}