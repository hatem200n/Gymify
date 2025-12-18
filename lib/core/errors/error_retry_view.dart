import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';

class ErrorRetryView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorRetryView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.sp,
              color: Colors.redAccent,
            ),
            16.verticalSpace,
            message.makeBodyText(context),
            24.verticalSpace,
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: "إعادة المحاولة".makeBodyText(context),
            ),
          ],
        ),
      ),
    );
  }
}
