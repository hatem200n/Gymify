import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

extension StringWidgetExtension on String {
  Widget makeTitleText(
    BuildContext context, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    bool bold = true,
    int? fontSize,
  }) {
    final theme = Theme.of(context).textTheme;
    return Text(
      this,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: theme.titleLarge?.copyWith(
        letterSpacing: 0.5,
        fontSize: (fontSize ?? 18).sp,
        color: color,
        fontWeight: bold ? FontWeight.bold : FontWeight.w500,
        fontFamily: GoogleFonts.oswald().fontFamily,
      ),
    );
  }

  Widget makeBodyText(
    BuildContext context, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    bool isSecondary = false,
    int? fontSize,
  }) {
    final theme = Theme.of(context).textTheme;
    return Text(
      this,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: theme.bodyMedium?.copyWith(
        fontSize: (fontSize ?? 14).sp,
        color: color,
        fontFamily: GoogleFonts.oswald().fontFamily,
      ),
    );
  }

  Widget makeLabelText(
    BuildContext context, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    int? fontSize,
  }) {
    final theme = Theme.of(context).textTheme;
    return Text(
      this,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: theme.labelMedium?.copyWith(
        color: color ,
        fontFamily: GoogleFonts.oswald().fontFamily,
        fontSize: (fontSize ?? 12).sp,
      ),
    );
  }
}
