import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymfiy/core/theme/app_colors.dart';

extension StringWidgetExtension on String {
  Widget makeTitleText(
    BuildContext context, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    bool bold = true,
  }) {
    final theme = Theme.of(context).textTheme;
    return Text(
      this,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: theme.titleLarge?.copyWith(
        color: color ?? AppColors.primaryText,
        fontWeight: bold ? FontWeight.bold : FontWeight.w500,
        fontFamily: GoogleFonts.cairo().fontFamily,
      ),
    );
  }

  Widget makeBodyText(
    BuildContext context, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    bool isSecondary = false,
  }) {
    final theme = Theme.of(context).textTheme;
    return Text(
      this,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: theme.bodyMedium?.copyWith(
        color: color ??
            (isSecondary ? AppColors.secondaryText : AppColors.primaryText),
        fontFamily: GoogleFonts.cairo().fontFamily,
      ),
    );
  }

  Widget makeLabelText(
    BuildContext context, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) {
    final theme = Theme.of(context).textTheme;
    return Text(
      this,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: theme.labelMedium?.copyWith(
        color: color ?? AppColors.hintText,
        fontFamily: GoogleFonts.cairo().fontFamily,
        fontSize: 12,
      ),
    );
  }
}
