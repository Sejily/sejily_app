import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/helpers/storage_extension.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/widgets/build_field_with_label.dart';
import 'package:sejily/core/widgets/custom_text_field.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/features/authentication/presentation/widgets/authentication_button.dart';
import 'package:sejily/features/authentication/presentation/widgets/social_login_section.dart';
import '../manager/providers/login_provider.dart';
import '../manager/providers/progress_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    ref.read(loginNotifierProvider.notifier).login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginNotifierProvider);

    ref.listen<LoginState>(loginNotifierProvider, (prev, next) {
      if (next.result != null) {
        next.result!.when(
          onSuccess: (data) async {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(AppStrings.loginSuccessful)));

            ref.read(progressProvider.notifier).reset();
            await storage.setLoggedIn(true);
            if (context.mounted) {
              context.go(Routes.home);
            }
          },
          onFailure: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.message ?? AppStrings.loginError),
                backgroundColor: AppColors.red,
              ),
            );
          },
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              _title(),
              _loginTextFields(),
              CustomButton(
                isLoading: loginState.isLoading,
                text: AppStrings.login,
                onPressed: _login,
              ),
              const SizedBox(height: 10),
              _forgetPassOrDontHaveAnAccountSection(context),
              const SizedBox(height: 40),
              const SocialLoginSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _forgetPassOrDontHaveAnAccountSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: GestureDetector(
            onTap: () => context.go(Routes.forgetPassword),
            child: Text(
              AppStrings.forgetPassword,
              style: AppTextStyles.medium14.copyWith(
                color: AppColors.blackBlue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.dontHaveAccount, style: AppTextStyles.medium14),
            AuthenticationButton(
              onTap: () => context.go(Routes.selectRole),
              label: AppStrings.registerNow,
            ),
          ],
        ),
      ],
    );
  }

  Column _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.welcomeBack, style: AppTextStyles.bold24),
        const SizedBox(height: 8),
        Text(
          AppStrings.enterNextData,
          style: AppTextStyles.regular16.copyWith(
            color: AppColors.grayShade500,
          ),
        ),
      ],
    );
  }

  Padding _loginTextFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          BuildFieldWithLabel(
            required: true,
            label: AppStrings.email,
            child: CustomTextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          const SizedBox(height: 12),
          BuildFieldWithLabel(
            required: true,
            label: AppStrings.password,
            child: CustomTextField(
              controller: _passwordController,
              isObscured: true,
            ),
          ),
        ],
      ),
    );
  }
}
