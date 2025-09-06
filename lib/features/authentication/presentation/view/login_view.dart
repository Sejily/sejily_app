import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/widgets/custom_text_field.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/constants/api_endpoints.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sejily/core/newtorking/dio_factory.dart';
import 'package:sejily/core/utils/app_assets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();

  final bool _obscurePassword = true;
  bool _isLoading = false;

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("من فضلك أدخل البريد وكلمة المرور")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final dio = DioFactory.getDio();
      final response = await dio.post(
        ApiEndpoints.login,
        data: {"email": email, "password": password},
      );

      final data = response.data;

      if (response.statusCode == 200 && data["success"] == true) {
        final accessToken = data["data"]["accessToken"];
        final refreshToken = data["data"]["refreshToken"];

        await storage.write(key: "accessToken", value: accessToken);
        await storage.write(key: "refreshToken", value: refreshToken);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("تم تسجيل الدخول بنجاح")));
        context.go(Routes.home);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "فشل تسجيل الدخول")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("خطأ في الاتصال بالسيرفر")));
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                      color: Colors.black,
                    ),
                    label: Text(
                      AppStrings.back,
                      style: AppTextStyles.regular14.copyWith(
                        color: AppColors.jetBlack,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(AppStrings.welcomeBack, style: AppTextStyles.bold24),
                const SizedBox(height: 8),

                Text(
                  AppStrings.enterNextData,
                  style: AppTextStyles.regular16.copyWith(
                    color: AppColors.gray,
                  ),
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
                  isObscured: _obscurePassword,
                ),

                const SizedBox(height: 30),
                CustomButton(
                  onPressed: _isLoading ? null : _login,
                  text: AppStrings.login,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : null,
                ),

                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.go(Routes.forgetPassword),
                    child: Text(
                      AppStrings.forgetPassword,
                      style: AppTextStyles.regular14.copyWith(
                        color: AppColors.blackBlue,
                      ),
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
                      onPressed: () => context.go(Routes.register),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(205, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        AppStrings.registerNow,
                        style: AppTextStyles.regular14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        AppStrings.orLoginWith,
                        style: AppTextStyles.regular14,
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Assets.google, height: 20),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                AppStrings.google,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.regular14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.apple, size: 20),
                        label: Flexible(
                          child: Text(
                            AppStrings.icloud,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.regular14,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
