import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gymfiy/core/common/widgets/premium_button.dart';
import 'package:gymfiy/core/common/widgets/premium_text_field.dart';
import 'package:gymfiy/core/router/go_router_provider.dart';
import 'package:gymfiy/core/theme/app_colors.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';
import 'package:gymfiy/features/auth/presentation/providers/auth_notifier.dart';
import 'package:gymfiy/features/auth/presentation/screens/signup_sheet.dart';
import 'package:gymfiy/features/auth/presentation/widgets/signup_logo_text.dart';

class LoginSheet extends ConsumerStatefulWidget {
  const LoginSheet({super.key});

  @override
  ConsumerState<LoginSheet> createState() => _LoginSheetState();
}

class _LoginSheetState extends ConsumerState<LoginSheet> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(authNotifierProvider);
    final providerNotifire = ref.read(authNotifierProvider.notifier);
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomPadding),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                  child: Hero(tag: 'logo text', child: SignupLogoText())),
              "Welcome Back Coach!".makeTitleText(context),
              // 8.verticalSpace,
              // 'Create your new account in seconds'
              //     .makeBodyText(context, isSecondary: true),
              25.verticalSpace,

              PremiumTextField(
                controller: _emailController,
                labelText: "Email",
                hintText: "example@gmail.com",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return "invald email";
                  }
                  return null;
                },
              ),
              20.verticalSpace,
              PremiumTextField(
                controller: _passwordController,
                labelText: "password",
                hintText: '**********',
                isPassword: true,
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return "password must be more than 8 latters and numbers";
                  }
                  return null;
                },
              ),

              24.verticalSpace,
              PremiumButton(
                text: 'login',
                onPressed: () async {
                  // 1. ضيف async هنا
                  if (_formKey.currentState!.validate()) {
                    // 2. استخدم await باش البرنامج ينتظر رد الفايربيز
                    await providerNotifire.signIn(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    );

                    // 3. توا بعد ما كملت الدالة، نشيكوا على الحالة
                    if (!provider.hasError) {
                      if (context.mounted) {
                        // لو نجح، سكر الصفحة وامشي للهوم
                        context.go(AppRoutes.home);
                      }
                    } else {
                      // لو فشل، اعرض الخطأ الحقيقي
                      if (context.mounted) {
                        context.pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: ("البريد او كلمة المرور غير صحيحة")
                                .makeBodyText(context),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  }
                },
              ),
              20.verticalSpace,
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: 'أو'.makeLabelText(context),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          context.pop();
                          showModalBottomSheet(
                            isScrollControlled: true,
                            constraints: BoxConstraints(maxHeight: 700.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.vertical(
                                  top: Radius.circular(20.r)),
                            ),
                            context: context,
                            builder: (context) => const SignupSheet(),
                          );
                        },
                        child: Container(
                          height: 40.h,
                          padding: EdgeInsets.all(3.r),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusGeometry.circular(200.r),
                              border:
                                  Border.all(color: AppColors.secondaryText)),
                          child: Image.asset("assets/icons/have-account.webp"),
                        ),
                      ),
                      "don't have account".makeBodyText(context)
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      await providerNotifire.signInWithGoogle();
                      // await providerNotifire.signOut();

                      // 💡 لو العملية تمت بنجاح (مفيش Error)
                      if (!provider.hasError) {
                        if (context.mounted) {
                          context.pop();
                          context.go(AppRoutes.home);
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
                    child: Column(
                      children: [
                        Container(
                          height: 40.h,
                          padding: EdgeInsets.all(3.r),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusGeometry.circular(200.r),
                              border:
                                  Border.all(color: AppColors.secondaryText)),
                          child: Image.asset("assets/icons/google-icon.jpg"),
                        ),
                        "google".makeBodyText(context)
                      ],
                    ),
                  ),
                ],
              ),
              10.verticalSpace
            ],
          ),
        ),
      ),
    );
  }
}
