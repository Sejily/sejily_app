import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/utils/app_assets.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_validators.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/features/authentication/presentation/widgets/countdown_timer.dart';
import 'package:sejily/features/authentication/presentation/widgets/otp_input_field.dart';

class OtpVerificationView extends StatefulWidget {
  const OtpVerificationView({super.key, required this.email});
  final String email;

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  final _pinController = TextEditingController();
  final _timerKey = GlobalKey<CountdownTimerState>();
  String? _error;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _pinController.addListener(() => setState(() {}));
  }

  void _onTimerEnd() => setState(() => _canResend = true);

  void _resendCode() {
    if (_canResend) {
      setState(() {
        _canResend = false;
        _error = null;
      });
      _timerKey.currentState?.restart();
      // TODO: Implement resend logic
    }
  }

  void _onOtpChanged(String value) {
    setState(() {
      if (_error != null) _error = null;
    });
  }

  void _verifyOtp() {
    final validationError = AppValidators.otpValidator(_pinController.text);

    if (validationError != null) {
      setState(() => _error = validationError);
      return;
    }
    setState(() => _error = null);
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isComplete = AppValidators.isOtpComplete(_pinController.text);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Verification Header
              _verificationHeader(),
              const SizedBox(height: 58),

              OtpInputField(
                controller: _pinController,
                onChanged: _onOtpChanged,
                onCompleted: (_) {},
                hasError: _error != null,
              ),

              //* Resend OTP code part
              _resendOtpCodeSection(),
              CustomButton(
                onPressed: isComplete
                    ? () {
                        _verifyOtp();
                        final otp = _pinController.text.trim();
                        // TODO: Implement verification logic
                        context.go(Routes.completeUserData);
                      }
                    : () {},
                text: AppStrings.verify,
                backgroundColor: isComplete
                    ? AppColors.darkBlue
                    : AppColors.lightGray,
                foregroundColor: isComplete ? AppColors.white : AppColors.gray,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _verificationHeader() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: AppColors.lightGray.withValues(alpha: 0.1),
          ),
          padding: const EdgeInsets.all(15),
          child: Image.asset(Assets.validationCode, height: 30, width: 30),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            AppStrings.enterVerificationCode,
            style: AppTextStyles.bold24.copyWith(color: AppColors.jetBlack),
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          AppStrings.verificationCodeSent,
          style: AppTextStyles.regular14.copyWith(color: AppColors.gray),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          widget.email,
          style: AppTextStyles.medium16.copyWith(color: AppColors.jetBlack),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Padding _resendOtpCodeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          CountdownTimer(
            key: _timerKey,
            initialTime: 60,
            onTimerEnd: _onTimerEnd,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppStrings.didntReceiveCode, style: AppTextStyles.regular14),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: _canResend ? _resendCode : null,
                child: Text(
                  AppStrings.requestNewCode,
                  style: AppTextStyles.medium14.copyWith(
                    color: _canResend ? AppColors.darkBlue : AppColors.gray,
                    decoration: _canResend ? TextDecoration.underline : null,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
