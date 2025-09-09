import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/features/authentication/presentation/manager/providers/auth_provider.dart';
import 'package:sejily/features/authentication/presentation/manager/auth_state.dart';

class ResendOtpButton extends ConsumerWidget {
  const ResendOtpButton({
    super.key,
    required this.email,
    required this.canResend,
    required this.onSuccess,
    required this.onError,
  });

  final String email;
  final bool canResend;
  final VoidCallback onSuccess;
  final void Function(String error) onError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState == const AuthState.loading();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppStrings.didntReceiveCode, style: AppTextStyles.regular14),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: canResend && !isLoading ? () => _handleResend(ref) : null,
          child: Text(
            isLoading ? 'جاري الإرسال...' : AppStrings.requestNewCode,
            style: AppTextStyles.medium14.copyWith(
              color: canResend && !isLoading
                  ? AppColors.darkBlue
                  : AppColors.gray,
              decoration: canResend && !isLoading
                  ? TextDecoration.underline
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleResend(WidgetRef ref) async {
    try {
      await ref.read(authNotifierProvider.notifier).resendOtp(email: email);
      final authState = ref.read(authNotifierProvider);
      authState.maybeWhen(
        failure: (error) => onError(error.errorMessage),
        orElse: () => onSuccess(),
      );
    } catch (e) {
      onError('فشل في إعادة إرسال الرمز. يرجى المحاولة مرة أخرى.');
    }
  }
}
