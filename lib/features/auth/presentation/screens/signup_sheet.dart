import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymfiy/core/common/widgets/premium_button.dart';
import 'package:gymfiy/core/common/widgets/premium_text_field.dart';
import 'package:gymfiy/core/common/widgets/secondary_button.dart';
import 'package:gymfiy/core/theme/app_colors.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';

class SignupSheet extends ConsumerStatefulWidget {
  const SignupSheet({super.key});

  @override
  ConsumerState<SignupSheet> createState() => _SignupSheetState();
}

class _SignupSheetState extends ConsumerState<SignupSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomPadding),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // العنوان
              "Let's get started! 💪 ".makeTitleText(context),
              8.verticalSpace,
              'Create your new account in seconds'
                  .makeBodyText(context, isSecondary: true),

              25.verticalSpace,
              // حقول الإدخال
              PremiumTextField(
                controller: _nameController,
                labelText: "user name",
                hintText: "user name",
                keyboardType: TextInputType.text,
              ),
              20.verticalSpace,
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
              20.verticalSpace,
              PremiumTextField(
                controller: _confirmPassword,
                labelText: 'confirm password',
                hintText: '**********',
                isPassword: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'password not march';
                  }
                  return null;
                },
              ),

              24.verticalSpace,
              // زر التسجيل
              PremiumButton(
                text: 'create account',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: call Signup Provider هنا
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
              // زر Google Sign-In
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 40.h,
                        padding: EdgeInsets.all(3.r),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusGeometry.circular(200.r),
                            border: Border.all(color: AppColors.secondaryText)),
                        child: Image.asset("assets/icons/have-account.webp"),
                      ),
                      "have an account".makeBodyText(context)
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 40.h,
                        padding: EdgeInsets.all(3.r),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusGeometry.circular(200.r),
                            border: Border.all(color: AppColors.secondaryText)),
                        child: Image.asset("assets/icons/google-icon.jpg"),
                      ),
                      "google".makeBodyText(context)
                    ],
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
