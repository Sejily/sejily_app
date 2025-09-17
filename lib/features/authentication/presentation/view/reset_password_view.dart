import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_validators.dart';
import 'package:sejily/core/widgets/custom_text_field.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/core/widgets/build_field_with_label.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/features/authentication/presentation/widgets/remembered_password_section.dart';
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
                backgroundColor: AppColors.red,
              ),
            );
          },
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 40),
                    BuildFieldWithLabel(
                      label: AppStrings.newPassword,
                      required: true,
                      child: CustomTextField(
                        controller: _newPasswordController,
                        isObscured: true,
                        validator: AppValidators.newPasswordValidator,
                      ),
                    ),
                    const SizedBox(height: 12),
                    BuildFieldWithLabel(
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
                    const SizedBox(height: 30),
                    CustomButton(
                      isLoading: state.isLoading,
                      text: AppStrings.changePassword,
                      loadingText: AppStrings.changing,
                      onPressed: _resetPassword,
                    ),
                  ],
                ),
              ),
              RememberedPasswordSection(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildHeader() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: AppColors.lightGray.withValues(alpha: 0.1),
          ),
          padding: const EdgeInsets.all(15),
          child: Text(
            "***",
            style: AppTextStyles.bold24.copyWith(color: AppColors.darkBlue),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(AppStrings.enterNewPassword, style: AppTextStyles.bold20),
        ),
        Text(
          AppStrings.enterNewPasswordDescription,
          textAlign: TextAlign.center,
          style: AppTextStyles.regular14.copyWith(color: AppColors.black54),
        ),
      ],
    );
  }
}
