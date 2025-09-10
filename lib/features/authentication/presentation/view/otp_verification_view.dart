import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/utils/app_assets.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_validators.dart';
import 'package:sejily/features/authentication/presentation/widgets/countdown_timer.dart';
import 'package:sejily/features/authentication/presentation/widgets/otp_input_field.dart';
import 'package:sejily/features/authentication/presentation/widgets/resend_otp_button.dart';
import 'package:sejily/features/authentication/presentation/widgets/verification_button.dart';

class OtpVerificationView extends ConsumerStatefulWidget {
  const OtpVerificationView({super.key, required this.email});
  final String email;

  @override
  ConsumerState<OtpVerificationView> createState() =>
      _OtpVerificationViewState();
}

class _OtpVerificationViewState extends ConsumerState<OtpVerificationView> {
  final _pinController = TextEditingController();
  final _timerKey = GlobalKey<CountdownTimerState>();
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _pinController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _onResendSuccess() {
    setState(() => _canResend = false);
    _timerKey.currentState?.restart();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم إعادة إرسال رمز التحقق بنجاح'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _onError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error), backgroundColor: AppColors.lightRed),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isComplete = AppValidators.isOtpComplete(_pinController.text);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeader(),
              const SizedBox(height: 58),

              OtpInputField(controller: _pinController),

              const SizedBox(height: 24),

              _buildResendSection(),

              VerificationButton(
                email: widget.email,
                otp: _pinController.text.trim(),
                isComplete: isComplete,
                onError: _onError,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        //* Image
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: AppColors.lightGray.withValues(alpha: 0.1),
          ),
          padding: const EdgeInsets.all(15),
          child: Image.asset(Assets.validationCode, height: 30, width: 30),
        ),
        const SizedBox(height: 8),
        //* Title
        Text(
          AppStrings.enterVerificationCode,
          style: AppTextStyles.bold24.copyWith(color: AppColors.jetBlack),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
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

  Widget _buildResendSection() {
    return Column(
      children: [
        CountdownTimer(
          key: _timerKey,
          initialTime: 60,
          onTimerEnd: () => setState(() => _canResend = true),
        ),
        const SizedBox(height: 4),
        ResendOtpButton(
          email: widget.email,
          canResend: _canResend,
          onSuccess: _onResendSuccess,
          onError: _onError,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
