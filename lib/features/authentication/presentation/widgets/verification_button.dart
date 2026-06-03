import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/features/authentication/presentation/manager/providers/register_provider.dart';
import 'package:sejily/features/authentication/presentation/manager/auth_state.dart';

class VerificationButton extends ConsumerWidget {
  const VerificationButton({
    super.key,
    required this.route,
    required this.email,
    required this.otp,
    required this.isComplete,
    required this.onError,
    this.routeData,
  });

  final String email;
  final String otp;
  final bool isComplete;
  final String route;
  final Map<String, dynamic>? routeData;
  final void Function(String error) onError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(registerNotifierProvider);
    final isLoading = authState == const AuthState.loading();
    final isActivated = isComplete && !isLoading;

    // Determine if this is password reset flow
    final isPasswordReset = route == Routes.resetPassword;

    ref.listen<AuthState>(registerNotifierProvider, (previous, next) {
      next.maybeWhen(
        success: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              routeData != null
                  ? context.go(route, extra: routeData)
                  : context.go(route);
            }
          });
        },
        failure: (error) => onError(error.errorMessage),
        orElse: () {},
      );
    });

    return CustomButton(
      isLoading: isLoading,
      text: AppStrings.verify,
      loadingText: AppStrings.checking,
      onPressed: () async {
        if (isPasswordReset) {
          if (context.mounted) {
            routeData != null
                ? context.push(route, extra: routeData)
                : context.go(route);
          }
        } else {
          await ref
              .read(registerNotifierProvider.notifier)
              .verifyOtp(email: email, otp: otp);
        }
      },
    );
  }
}
