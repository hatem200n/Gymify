import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gymfiy/core/common/widgets/premium_button.dart';
import 'package:gymfiy/core/local/storage_provider.dart';
import 'package:gymfiy/core/router/go_router_provider.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';
import 'package:gymfiy/features/auth/presentation/providers/auth_notifier.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "مرحباً يا طير، $userName".makeTitleText(context),
            "جاهز لتمارين اليوم؟".makeBodyText(context),
            PremiumButton(
              text: "تسجيل خروج",
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
            ),
          ],
        ),
      ),
    );
  }
}
