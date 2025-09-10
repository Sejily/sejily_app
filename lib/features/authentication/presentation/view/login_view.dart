import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/helpers/storage_extension.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/widgets/custom_text_field.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/core/routes/routes.dart';
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
          onSuccess: (data) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تم تسجيل الدخول بنجاح")),
            );

            ref.read(progressProvider.notifier).reset();
            ref
                .read(progressProvider.notifier)
                .updateProgressForRoute(Routes.completeUserData);

            storage.setLoggedIn(true);
            context.go(Routes.home);
          },
          onFailure: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  error.message ?? 'حدث خطأ في تسجيل الدخول، حاول مرة أخرى',
                ),
                backgroundColor: Colors.red,
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
              Text(AppStrings.welcomeBack, style: AppTextStyles.bold24),
              const SizedBox(height: 8),
              Text(
                AppStrings.enterNextData,
                style: AppTextStyles.regular16.copyWith(color: AppColors.gray),
              ),
              const SizedBox(height: 40),
              Text(
                AppStrings.email,
                style: AppTextStyles.semiBold18.copyWith(
                  color: AppColors.jetBlack,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.password,
                style: AppTextStyles.semiBold18.copyWith(
                  color: AppColors.jetBlack,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: _passwordController,
                isObscured: true,
              ),
              const SizedBox(height: 30),
              CustomButton(
                onPressed: loginState.isLoading ? null : _login,
                text: AppStrings.login,
                child: loginState.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : null,
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => context.go(Routes.forgetPassword),
                child: Text(
                  AppStrings.forgetPassword,
                  style: AppTextStyles.regular14.copyWith(
                    color: AppColors.blackBlue,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    AppStrings.dontHaveAccount,
                    style: AppTextStyles.regular14,
                  ),
                  OutlinedButton(
                    onPressed: () => context.go(Routes.selectRole),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(205, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(AppStrings.registerNow),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const SocialLoginSection(),
            ],
          ),
        ),
      ),
    );
  }
}
