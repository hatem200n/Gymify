import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymfiy/core/common/widgets/outline_button.dart';
import 'package:gymfiy/core/common/widgets/premium_button.dart';
import 'package:gymfiy/core/theme/app_colors.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';
import 'package:gymfiy/features/auth/presentation/screens/login_sheet.dart';
import 'package:gymfiy/features/auth/presentation/screens/signup_sheet.dart';
import 'package:gymfiy/features/onboarding/presentation/widgets/logo_text.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
            child: Image.asset(
          "assets/images/onboarding-background.png",
          fit: BoxFit.fitHeight,
        )),
        Positioned.fill(
            child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.black.withValues(alpha: 0),
                Colors.black.withValues(alpha: 0.3),
                Colors.black.withValues(alpha: 1),
              ])),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Hero(tag: 'logo text', child: LogoText()),
                "FIRST STEP TO HEALTHY BODY"
                    .makeTitleText(context, color: AppColors.lightBackground),
                100.verticalSpace,
                PremiumButton(
                    text: "join now",
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        barrierColor: Colors.transparent,
                        constraints: BoxConstraints(maxHeight: 700.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.vertical(
                              top: Radius.circular(20.r)),
                        ),
                        context: context,
                        builder: (context) => const SignupSheet(),
                      );
                    }),
                20.verticalSpace,
                OutLineButton(
                    text: 'already have an account',
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        barrierColor: Colors.transparent,
                        constraints: BoxConstraints(maxHeight: 500.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.vertical(
                              top: Radius.circular(20.r)),
                        ),
                        context: context,
                        builder: (context) => const LoginSheet(),
                      );
                      // setOnboardingViewed(ref);
                      // context.go(AppRoutes.home);
                    }),
                80.verticalSpace
              ],
            ),
          ),
        )),
      ],
    ));
  }
}
