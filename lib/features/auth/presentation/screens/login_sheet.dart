import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gymfiy/core/common/widgets/primary_button.dart';
import 'package:gymfiy/core/common/widgets/primary_text_field.dart';
import 'package:gymfiy/core/router/go_router_provider.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';
import 'package:gymfiy/features/auth/presentation/providers/auth_notifier.dart';
import 'package:gymfiy/features/auth/presentation/screens/signup_sheet.dart';
import 'package:gymfiy/features/auth/presentation/widgets/signup_logo_text.dart';
import 'package:gymfiy/features/auth/presentation/widgets/social_action_icon.dart';

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
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AsyncLoading;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          24, 24, 24, 24 + MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Hero(tag: 'logo text', child: SignupLogoText()),
              "Welcome Back Coach!".makeTitleText(context),
              25.verticalSpace,
              _buildTextFields(),
              24.verticalSpace,
              if (isLoading)
                const CircularProgressIndicator()
              else
                PrimaryButton(
                  isLoading: isLoading,
                  text: 'Login',
                  onPressed: () => _handleLogin(ref),
                ),
              _buildDivider(context),
              _buildSocialLogin(context, ref, isLoading),
              10.verticalSpace
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Methods ---

  Widget _buildTextFields() {
    return Column(
      children: [
        PrimaryTextField(
          controller: _emailController,
          labelText: "Email",
          hintText: "example@gmail.com",
          keyboardType: TextInputType.emailAddress,
          validator: (v) =>
              (v == null || !v.contains('@')) ? "Invalid email" : null,
        ),
        20.verticalSpace,
        PrimaryTextField(
          controller: _passwordController,
          labelText: "Password",
          isPassword: true,
          validator: (v) =>
              (v == null || v.length < 8) ? "Min 8 characters" : null,
        ),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: 'أو'.makeLabelText(context),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }

  Widget _buildSocialLogin(
      BuildContext context, WidgetRef ref, bool isLoading) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SocialActionIcon(
          icon: "assets/icons/have-account.webp",
          label: "Sign Up",
          onTap: () => _switchToSignup(context),
        ),
        SocialActionIcon(
          icon: "assets/icons/google-icon.jpg",
          label: "Google",
          onTap: () => _handleGoogleSignIn(ref, context),
        ),
      ],
    );
  }

  // --- Logic ---

  Future<void> _handleLogin(WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      await ref.read(authNotifierProvider.notifier).signIn(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
      _checkResult(ref);
    }
  }

  Future<void> _handleGoogleSignIn(WidgetRef ref, BuildContext context) async {
    await ref.read(authNotifierProvider.notifier).signInWithGoogle();
    _checkResult(ref);
  }

  void _checkResult(WidgetRef ref) {
    final state = ref.read(authNotifierProvider);

    if (!state.hasError) {
      if (mounted) context.go(AppRoutes.home);
    } else {
      // 💡 الحل هنا:
      // نعرضوا الخطأ داخل الـ BottomSheet أولاً
      // أو نستخدموا Overlay عشان يطلع فوق كل شيء
      _showTopSnackBar(state.error.toString());
    }
  }

  void _showTopSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: message.makeBodyText(context),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating, // يخليه عائم
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 150, // يخليه يطلع فوق!
          left: 20,
          right: 20,
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _switchToSignup(BuildContext context) {
    context.pop();
    showModalBottomSheet(
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: 700.h),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      context: context,
      builder: (context) => const SignupSheet(),
    );
  }
}
