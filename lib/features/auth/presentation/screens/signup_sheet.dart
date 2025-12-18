import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gymfiy/core/common/widgets/primary_button.dart';
import 'package:gymfiy/core/common/widgets/primary_text_field.dart';
import 'package:gymfiy/core/router/go_router_provider.dart';
import 'package:gymfiy/core/utils/extentions/string_extention.dart';
import 'package:gymfiy/features/auth/presentation/providers/auth_notifier.dart';
import 'package:gymfiy/features/auth/presentation/screens/login_sheet.dart';
import 'package:gymfiy/features/auth/presentation/widgets/signup_logo_text.dart';
import 'package:gymfiy/features/auth/presentation/widgets/social_action_icon.dart';

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
              "Let's get started!".makeTitleText(context),
              25.verticalSpace,
              _buildFormFields(),
              24.verticalSpace,
              if (isLoading)
                const CircularProgressIndicator()
              else
                PrimaryButton(
                  text: 'Create Account',
                  onPressed: () => _handleSignup(ref),
                ),
              _buildDivider(context),
              _buildSocialSection(context, ref, isLoading),
              10.verticalSpace
            ],
          ),
        ),
      ),
    );
  }

  // --- (UI Components) ---

  Widget _buildFormFields() {
    return Column(
      children: [
        PrimaryTextField(
          controller: _nameController,
          labelText: "User Name",
          hintText: "Enter your name",
        ),
        20.verticalSpace,
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
        20.verticalSpace,
        PrimaryTextField(
          controller: _confirmPassword,
          labelText: 'Confirm Password',
          isPassword: true,
          validator: (v) =>
              (v != _passwordController.text) ? 'Passwords do not match' : null,
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

  Widget _buildSocialSection(
      BuildContext context, WidgetRef ref, bool isLoading) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SocialActionIcon(
          icon: "assets/icons/have-account.webp",
          label: "Have account",
          onTap: () => _switchToLogin(context),
        ),
        SocialActionIcon(
          icon: "assets/icons/google-icon.jpg",
          label: "Google",
          onTap: () => _handleGoogleSignIn(ref),
        ),
      ],
    );
  }

  // --- Logic ---

  Future<void> _handleSignup(WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      await ref.read(authNotifierProvider.notifier).signUp(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
      _checkStatus(ref);
    }
  }

  Future<void> _handleGoogleSignIn(WidgetRef ref) async {
    await ref.read(authNotifierProvider.notifier).signInWithGoogle();
    _checkStatus(ref);
  }

  void _checkStatus(WidgetRef ref) {
    final state = ref.read(authNotifierProvider);
    if (!state.hasError) {
      if (mounted) context.go(AppRoutes.home);
    } else {
      _showError(state.error.toString());
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: message.makeBodyText(context),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 160,
          left: 20,
          right: 20,
        ),
      ),
    );
  }

  void _switchToLogin(BuildContext context) {
    context.pop();
    showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: 500.h),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      context: context,
      builder: (context) => const LoginSheet(),
    );
  }
}
