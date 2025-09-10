import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_validators.dart';
import 'package:sejily/core/widgets/custom_text_field.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/core/widgets/build_field_with_label.dart';
import 'package:sejily/core/widgets/custom_app_bar.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/routes/routes.dart';
import '../manager/providers/reset_notifier.dart';
import '../manager/providers/progress_provider.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  final String email;
  final String otp;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _resetPassword() {
    if (!_formKey.currentState!.validate()) return;

    ref
        .read(resetPasswordNotifierProvider.notifier)
        .resetPassword(
          widget.email,
          widget.otp,
          _newPasswordController.text.trim(),
          _confirmPasswordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(resetPasswordNotifierProvider);

    ref.listen<ResetPasswordState>(resetPasswordNotifierProvider, (
      previous,
      next,
    ) {
      if (next.result != null) {
        next.result!.when(
          onSuccess: (data) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تم تغيير كلمة المرور بنجاح")),
            );

            ref
                .read(progressProvider.notifier)
                .updateProgressForRoute(Routes.success);

            context.go(Routes.success);
          },
          onFailure: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  error.message ??
                      'حدث خطأ في تغيير كلمة المرور، حاول مرة أخرى',
                ),
                backgroundColor: Colors.red,
              ),
            );
          },
        );
      }
    });

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: CustomAppBar(),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Spacer(),
                      Text(
                        "***",
                        style: AppTextStyles.bold24.copyWith(
                          fontSize: 40,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppStrings.enterNewPassword,
                        style: AppTextStyles.bold20,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          AppStrings.enterNewPasswordDescription,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.regular14.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: BuildFieldWithLabel(
                          label: AppStrings.newPassword,
                          required: true,
                          child: CustomTextField(
                            controller: _newPasswordController,
                            isObscured: true,
                            validator: AppValidators.newPasswordValidator,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: BuildFieldWithLabel(
                          label: AppStrings.confirmNewPassword,
                          required: true,
                          child: CustomTextField(
                            controller: _confirmPasswordController,
                            isObscured: true,
                            validator: (value) =>
                                AppValidators.confirmPasswordValidator(
                                  value,
                                  _newPasswordController.text,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: CustomButton(
                          onPressed: state.isLoading ? null : _resetPassword,
                          text: AppStrings.changePassword,
                          child: state.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.forgotPassword,
                              style: AppTextStyles.regular14.copyWith(
                                color: Colors.black54,
                              ),
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
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
