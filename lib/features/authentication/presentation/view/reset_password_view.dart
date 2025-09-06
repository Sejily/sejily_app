import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/widgets/custom_text_field.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/constants/api_endpoints.dart';
import 'package:sejily/core/newtorking/dio_factory.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;

  Future<void> resetPassword() async {
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("من فضلك أدخل كلمة المرور الجديدة")),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("كلمتا المرور غير متطابقتين")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final dio = DioFactory.getDio();
      final response = await dio.post(
        ApiEndpoints.resetPassword,
        data: {"newPassword": newPassword},
      );

      final data = response.data;

      if (response.statusCode == 200 && data["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تم تغيير كلمة المرور بنجاح ")),
        );

        context.go(Routes.login);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "حدث خطأ أثناء التغيير")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("فشل الاتصال بالسيرفر")));
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        body: SafeArea(
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
              Text(AppStrings.enterNewPassword, style: AppTextStyles.bold20),
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
                child: CustomTextField(
                  controller: _newPasswordController,
                  isObscured: true,
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomTextField(
                  controller: _confirmPasswordController,
                  isObscured: true,
                  keyboardType: TextInputType.text,
                ),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CustomButton(
                  onPressed: () => context.go(Routes.success),
                  text: AppStrings.changePassword,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
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
                          color: const Color(0xFF1D3557),
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
    );
  }
}
