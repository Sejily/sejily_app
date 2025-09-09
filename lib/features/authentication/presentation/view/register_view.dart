import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_validators.dart';
import 'package:sejily/core/widgets/build_field_with_label.dart';
import 'package:sejily/core/widgets/custom_text_field.dart';
import 'package:sejily/features/authentication/presentation/widgets/authentication_button.dart';
import 'package:sejily/features/authentication/presentation/widgets/register_button.dart';
import 'package:sejily/features/authentication/presentation/widgets/social_login_section.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    AppStrings.registerNowFree,
                    style: AppTextStyles.bold24.copyWith(
                      color: AppColors.jetBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.enterDataToCreateAccount,
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.gray,
                    ),
                  ),

                  _registerTextFields(),
                  //* Register Button
                  RegisterButton(
                    emailController: _emailController,
                    formKey: _formKey,
                    passwordController: _passwordController,
                    nameController: _nameController,
                  ),
                  //* Terms and Conditions
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        AppStrings.agreeToUsageAndPrivacyPolicies,
                        style: AppTextStyles.regular12.copyWith(
                          color: AppColors.gray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  //* Already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.haveAccountAlready,
                        style: AppTextStyles.medium14,
                      ),
                      const SizedBox(width: 8),
                      AuthenticationButton(
                        onTap: () => context.go(Routes.login),
                        label: AppStrings.loginNow,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  //* Social Login Section
                  SocialLoginSection(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerTextFields() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 24),
      child: Column(
        children: [
          // Name Field
          BuildFieldWithLabel(
            label: AppStrings.fullNameLabel,
            child: CustomTextField(
              controller: _nameController,
              validator: AppValidators.nameValidator,
            ),
          ),
          const SizedBox(height: 12),
          // Email Field
          BuildFieldWithLabel(
            label: AppStrings.emailAddress,
            child: CustomTextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: AppValidators.emailValidator,
            ),
          ),
          const SizedBox(height: 12),
          // Password Field
          BuildFieldWithLabel(
            label: AppStrings.passwordLabel,
            child: CustomTextField(
              controller: _passwordController,
              isObscured: true,
              validator: AppValidators.newPasswordValidator,
            ),
          ),
        ],
      ),
    );
  }
}
