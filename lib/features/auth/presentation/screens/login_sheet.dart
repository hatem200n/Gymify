import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gymfiy/core/common/widgets/premium_button.dart';
import 'package:gymfiy/core/common/widgets/premium_text_field.dart';
import 'package:gymfiy/core/common/widgets/secondary_button.dart';
import 'package:gymfiy/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';

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
    // 💡 مهم: عشان الـ Keyboard ما يديرش Overflow للـ Widget
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomPadding),
      child: SingleChildScrollView(
        // عشان تقدر تدير Scroll لما تطلع الكيبورد
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // العنوان
              '👋 مرحباً بعودتك!'.makeTitleText(context),
              8.verticalSpace,
              'سجل دخولك عشان تبدأ التمارين'
                  .makeBodyText(context, isSecondary: true),

              32.verticalSpace,

              // حقول الإدخال
              PremiumTextField(
                controller: _emailController,
                labelText: 'البريد الإلكتروني',
                hintText: 'ادخل الإيميل متاعك',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'اكتب إيميل صحيح، يا طير.';
                  }
                  return null;
                },
              ),
              20.verticalSpace,
              PremiumTextField(
                controller: _passwordController,
                labelText: 'كلمة السر',
                hintText: 'ادخل كلمة السر',
                isPassword: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'كلمة السر قصيرة (أقل من 6 حروف)';
                  }
                  return null;
                },
              ),
              10.verticalSpace, // زر نسيت كلمة السر
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // هنا ممكن نديرو modal ثاني لنسيان كلمة السر
                  },
                  child: 'نسيت كلمة السر؟'
                      .makeBodyText(context, color: AppColors.primary),
                ),
              ),

              24.verticalSpace,
              // زر الدخول
              PremiumButton(
                text: 'دخول',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: call Login Provider هنا
                  }
                },
              ),

              20.verticalSpace,
              // خط فاصل "أو"
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
              SecondaryButton(
                text: 'سجل بـ Google',
                onPressed: () {
                  // TODO: call Google Sign-In Provider هنا
                },
              ),
              10.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
