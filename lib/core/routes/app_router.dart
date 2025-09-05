import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.onboarding,
    routes: [
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: Routes.selectRole,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => const Placeholder(),
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
