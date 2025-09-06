import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/features/authentication/presentation/view/complete_user_data_page.dart';
import 'package:sejily/features/authentication/presentation/view/data_review_page.dart';
import 'package:sejily/features/authentication/presentation/view/emergency_contact_page.dart';
import 'package:sejily/features/authentication/presentation/view/forget_password_view.dart';
import 'package:sejily/features/authentication/presentation/view/login_view.dart';
import 'package:sejily/features/authentication/presentation/view/otp_verification_view.dart';
import 'package:sejily/features/authentication/presentation/view/register_view.dart';
import 'package:sejily/features/authentication/presentation/view/reset_password_view.dart';
import 'package:sejily/features/authentication/presentation/view/role_selection_view.dart';
import 'package:sejily/features/authentication/presentation/view/success_reset_view.dart';
import 'package:sejily/features/authentication/presentation/view/upload_national_id_page.dart';
import 'package:sejily/features/authentication/presentation/view/upload_personal_photo_page.dart';
import 'package:sejily/features/authentication/presentation/view/upload_hospital_affiliation_page.dart';
import 'package:sejily/features/authentication/presentation/view/upload_medical_license_page.dart';
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
        builder: (context, state) => const RegisterView(),
      ),

      GoRoute(
        path: Routes.verifyOtp,
        builder: (context, state) => const OtpPage(),
      ),

      GoRoute(
        path: Routes.registerOtpVerification,
        builder: (context, state) {
          final email = state.extra as String;
          return OtpVerificationView(email: email);
        },
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

      GoRoute(
        path: Routes.completeUserData,
        builder: (context, state) => const CompleteUserDataPage(),
      ),

      GoRoute(
        path: Routes.uploadNationalId,
        builder: (context, state) => const UploadNationalIdPage(),
      ),

      GoRoute(
        path: Routes.uploadPersonalPhoto,
        builder: (context, state) => const UploadPersonalPhotoPage(),
      ),

      GoRoute(
        path: Routes.uploadMedicalLicense,
        builder: (context, state) => const UploadMedicalLicensePage(),
      ),
      GoRoute(
        path: Routes.uploadHospitalAffiliation,
        builder: (context, state) => const UploadHospitalAffiliationPage(),
      ),
      GoRoute(
        path: Routes.emergencyContact,
        builder: (context, state) => const EmergencyContactPage(),
      ),
      GoRoute(
        path: Routes.dataReview,
        builder: (context, state) => const DataReviewPage(),
      ),
    ],
  );
}
