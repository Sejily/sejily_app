import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/features/authentication/presentation/view/register_view.dart';
import 'package:sejily/features/authentication/presentation/view/role_selection_view.dart';
import 'routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.selectRole,
    routes: [
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: Routes.selectRole,
        builder: (context, state) => const RoleSelectionView(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => const RegisterView(),
      ),

      GoRoute(
        path: Routes.verifyOtp,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: Routes.resetPassword,
        builder: (context, state) => const Placeholder(),
      ),

      GoRoute(
        path: Routes.success,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const Placeholder(),
      ),
    ],
  );
}
