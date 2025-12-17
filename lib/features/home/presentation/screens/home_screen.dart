import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gymfiy/core/common/widgets/outline_button.dart';
import 'package:gymfiy/core/common/widgets/premium_button.dart';
import 'package:gymfiy/core/common/widgets/secondary_button.dart';
import 'package:gymfiy/core/local/storage_provider.dart';
import 'package:gymfiy/core/router/go_router_provider.dart';
import 'package:gymfiy/core/theme/app_colors.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';
import 'package:gymfiy/features/auth/presentation/providers/auth_notifier.dart';
import 'package:gymfiy/features/auth/presentation/widgets/social_action_icon.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

// داخل HomeScreen (ConsumerWidget)
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 💡 هني نقروا الاسم باستخدام الـ Provider
    final userName = ref.watch(userNameProvider);
    final provider = ref.read(authNotifierProvider);
    final providerNotifire = ref.read(authNotifierProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 15.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: "Get Ready $userName".makeTitleText(context),
              subtitle: "we have a plan for you".makeBodyText(context),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                  IconButton(
                      onPressed: () {
                        providerNotifire.signOut();

                        // 💡 لو العملية تمت بنجاح (مفيش Error)
                        if (!provider.hasError) {
                          if (context.mounted) {
                            context.go(AppRoutes.onboarding);
                          }
                        } else {
                          // لو صار خطأ، اعرضه
                          final error = provider.error;
                          print(error);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('❌ فشل التسجيل: $error')),
                          );
                        }
                      },
                      icon: const Icon(Icons.logout)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(20.r)),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(20.r),
                      child: Image.asset(
                        "assets/images/banner-image2.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 40.w),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              end: Alignment.centerRight,
                              begin: Alignment.centerLeft,
                              colors: [
                                AppColors.primary.withValues(alpha: 0.7),
                                AppColors.primary.withValues(alpha: 0.4),
                                AppColors.primary.withValues(alpha: 0.2),
                              ]),
                          borderRadius: BorderRadius.circular(20.r)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "+150".makeLabelText(context,
                              fontSize: 40, color: AppColors.lightBackground),
                          "exercises for different\n muscle".makeBodyText(
                              context,
                              fontSize: 20,
                              color: AppColors.lightBackground),
                        const  Spacer(),
                          Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: AppColors.lightBackground,
                            ),
                            child: Row(
                              spacing: 5.r,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                "expoler now".makeLabelText(context,
                                    color: AppColors.darkBackground),
                                Container(
                                  padding: EdgeInsets.all(4.r),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: AppColors.lightBackground,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
