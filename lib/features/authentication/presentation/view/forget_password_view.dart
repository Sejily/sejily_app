import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/widgets/custom_text_field.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/constants/api_endpoints.dart';
import 'package:sejily/core/newtorking/dio_factory.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> sendOtp() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("من فضلك أدخل البريد الإلكتروني")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final dio = DioFactory.getDio();
      final response = await dio.post(
        ApiEndpoints.forgotPassword,
        data: {"email": email},
      );

      final data = response.data;

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تم إرسال رمز التحقق بنجاح ")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "حدث خطأ ما")),
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
                    // Icon
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
                      onPressed: () => context.go(Routes.verifyOtp),
                      text: AppStrings.sendVerificationCode,
                      child: _isLoading
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
