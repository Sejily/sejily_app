import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/widgets/custom_text_field.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/core/routes/routes.dart';
import '../manager/providers/forgot_password_notifier.dart';
import '../manager/providers/progress_provider.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  void _sendOtp() {
    final email = _emailController.text.trim();
    ref.read(forgotPasswordNotifierProvider.notifier).sendOtp(email);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotPasswordNotifierProvider);

    ref.listen<ForgotPasswordState>(forgotPasswordNotifierProvider, (
      prev,
      next,
    ) {
      if (next.result != null) {
        if (next.result!.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(next.result!.error!.message)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("تم إرسال رمز التحقق بنجاح")),
          );

          ref
              .read(progressProvider.notifier)
              .updateProgressForRoute(Routes.verifyOtp);

          context.push(Routes.verifyOtp, extra: _emailController.text.trim());
        }
      }
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.lock_outline,
                      size: 60,
                      color: Color(0xFF2C3E50),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      AppStrings.passwordResetTitle,
                      style: AppTextStyles.bold24.copyWith(
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.passwordResetDescription,
                      style: AppTextStyles.regular14.copyWith(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                          text: AppStrings.email,
                          style: AppTextStyles.regular14.copyWith(
                            color: Colors.black87,
                          ),
                          children: const [
                            TextSpan(
                              text: " *",
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    CustomTextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),

                    CustomButton(
                      onPressed: state.isLoading ? null : _sendOtp,
                      text: AppStrings.sendVerificationCode,
                      child: state.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : null,
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.forgotPassword,
                    style: AppTextStyles.medium14,
                  ),
                  GestureDetector(
                    onTap: () => context.go(Routes.login),
                    child: Text(
                      AppStrings.loginNow,
                      style: AppTextStyles.medium14.copyWith(
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
