import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/core/routes/routes.dart';
import '../manager/providers/progress_provider.dart';
import '../manager/providers/verification_notifier.dart';

class OtpPage extends ConsumerStatefulWidget {
  final String email;

  const OtpPage({super.key, required this.email});

  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  String _otpCode = "";

  void _verifyOtp() {
    ref.read(otpNotifierProvider.notifier).verifyOtp(widget.email, _otpCode);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(otpNotifierProvider);

    ref.listen<OtpState>(otpNotifierProvider, (prev, next) {
      if (next.result != null) {
        if (next.result!.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(next.result!.error!.message)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("تم التحقق من الرمز بنجاح")),
          );

          ref
              .read(progressProvider.notifier)
              .updateProgressForRoute(Routes.resetPassword);

          context.go(Routes.resetPassword);
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
                      AppStrings.enterVerificationCode,
                      style: AppTextStyles.bold24.copyWith(
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.verificationCodeSent,
                      style: AppTextStyles.regular14.copyWith(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.email,
                      style: AppTextStyles.medium14.copyWith(
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 30),

                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      keyboardType: TextInputType.number,
                      textStyle: AppTextStyles.bold20,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 55,
                        fieldWidth: 45,
                        inactiveColor: Colors.grey.shade400,
                        activeColor: AppColors.darkBlue,
                        selectedColor: AppColors.darkBlue,
                      ),
                      onChanged: (value) {
                        _otpCode = value;
                      },
                    ),

                    const SizedBox(height: 12),
                    Text(
                      AppStrings.verificationCodeTimeout,
                      style: AppTextStyles.medium14.copyWith(
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "${AppStrings.didntReceiveCode} ${AppStrings.requestNewCode}",
                      style: AppTextStyles.regular14.copyWith(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 20),
                    CustomButton(
                      onPressed: state.isLoading ? null : _verifyOtp,
                      text: AppStrings.verify,
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
