import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/features/authentication/presentation/view/forget_password_view.dart';
import 'package:sejily/features/authentication/presentation/view/login_view.dart';
import 'package:sejily/features/authentication/presentation/view/reset_password_view.dart';
import 'package:sejily/features/authentication/presentation/view/role_selection_view.dart';
import 'package:sejily/features/authentication/presentation/view/success_reset_view.dart';
import 'package:sejily/features/authentication/presentation/view/verification_view.dart';
import 'package:sejily/features/onboarding/presentation/onboarding_screen.dart';
import 'routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.onboarding,
    routes: [
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: Routes.selectRole,
        builder: (context, state) => const RoleSelectionView(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => const Placeholder(),
      ),

      GoRoute(
        path: Routes.verifyOtp,
        builder: (context, state) => const OtpPage(),
      ),
      GoRoute(
        path: Routes.forgetPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),

      GoRoute(
        path: Routes.resetPassword,
        builder: (context, state) => const ResetPasswordScreen(),
      ),

      GoRoute(
        path: Routes.success,
        builder: (context, state) => const SuccessResetPasswordPage(),
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const Placeholder(),
      ),
    ],
  );
}
