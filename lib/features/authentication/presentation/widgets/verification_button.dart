import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/features/authentication/presentation/manager/providers/auth_provider.dart';
import 'package:sejily/features/authentication/presentation/manager/auth_state.dart';

class VerificationButton extends ConsumerWidget {
  const VerificationButton({
    super.key,
    required this.email,
    required this.otp,
    required this.isComplete,
    required this.onError,
  });

  final String email;
  final String otp;
  final bool isComplete;
  final void Function(String error) onError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState == const AuthState.loading();
    final isActivated = isComplete && !isLoading;

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        success: () {
          // Use post frame callback to ensure navigation happens after the build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.go(Routes.completeUserData);
            }
          });
        },
        failure: (error) => onError(error.errorMessage),
        orElse: () {},
      );
    });

    return CustomButton(
      onPressed: isActivated
          ? () async {
              await ref
                  .read(authNotifierProvider.notifier)
                  .verifyOtp(email: email, otp: otp);
            }
          : null,
      text: isLoading ? AppStrings.checking : AppStrings.verify,
      backgroundColor: isActivated ? AppColors.darkBlue : AppColors.lightGray,
      foregroundColor: isActivated ? AppColors.white : AppColors.gray,
    );
  }
}
