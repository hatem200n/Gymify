import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:gymfiy/core/providers/theme_notifier.dart';
// تأكد من استيراد ملفات الألوان الخاصة بمشروعك الحالي
// import 'package:your_project/core/theme/app_colors.dart'; 

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // مراقبة حالة الثيم
    final themeMode = ref.watch(themeProvider);
    final bool isDarkMode = themeMode == ThemeMode.dark;

    return FlutterSwitch(
      width: 60.w,
      height: 30.h,
      toggleSize: 25.sp,
      value: isDarkMode,
      borderRadius: 30.r,
      padding: 2.r,
      // استخدم ألوان مشروعك الحالي (مثلاً AppColors.primary أو الرمادي)
      activeColor: Colors.grey.shade800, 
      inactiveColor: Colors.grey.shade300,
      activeToggleColor: const Color(0xFF212121),
      inactiveToggleColor: Colors.white,
      onToggle: (val) {
        // تغيير الثيم عن طريق الـ Notifier
        ref.read(themeProvider.notifier).toggleTheme();
      },
      activeIcon: const Icon(Icons.dark_mode, color: Colors.orange, size: 20),
      inactiveIcon: const Icon(Icons.light_mode, color: Colors.orange, size: 20),
    );
  }
}