import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/helpers/storage_extension.dart';
import 'package:sejily/core/services/secure_storage_service.dart';
import 'package:sejily/features/authentication/presentation/view/complete_user_data_page.dart';
import 'package:sejily/features/authentication/presentation/view/data_review_page.dart';
import 'package:sejily/features/authentication/presentation/view/emergency_contact_page.dart';
import 'package:sejily/features/authentication/presentation/view/forget_password_view.dart';
import 'package:sejily/features/home_user/file_upload/presentation/view/home_user_view.dart';
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
import 'package:sejily/features/home_user/profile/presention/view/edit_profile_view.dart';
import 'package:sejily/features/home_user/profile/presention/view/medical_complete_screen.dart';
import 'package:sejily/features/home_user/profile/presention/view/profile_view.dart';
import 'package:sejily/features/onboarding/presentation/onboarding_screen.dart';
import 'package:sejily/core/widgets/custom_bottom_navbar.dart';
import '../../features/home_user/profile/data/models/user_model.dart';
import 'routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    redirect: (context, state) {
      List<String> allowedPathsForNotLoggedIn = [
        Routes.login,
        Routes.register,
        Routes.completeUserData,
        Routes.dataReview,
        Routes.emergencyContact,
        Routes.forgetPassword,
        Routes.registerOtpVerification,
        Routes.resetPassword,
        Routes.selectRole,
      ];

      final isFirstTime = StorageService.instance.isFirstTime();
      final isLoggedIn = StorageService.instance.isLoggedIn();
      final currentPath = state.matchedLocation;

      if (isFirstTime) return Routes.onboarding;

      if (isLoggedIn) {
        if (currentPath == '/' || currentPath == Routes.login) {
          return Routes.home;
        }
      } else {
        if (!allowedPathsForNotLoggedIn.contains(currentPath)) {
          return Routes.login;
        }
      }

      return null;
    },
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
        path: Routes.register,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: Routes.verifyOtp,
        builder: (context, state) {
          final email = state.extra as String;
          return OtpPage(email: email);
        },
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
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          final email = args["email"] as String;
          final otp = args["otp"] as String;
          return ResetPasswordScreen(email: email, otp: otp);
        },
      ),
      GoRoute(
        path: Routes.success,
        builder: (context, state) => const SuccessResetPasswordPage(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          final location = state.uri.toString();
          int currentIndex = 0;

          if (location.startsWith(Routes.home))
            currentIndex = 0;
          else if (location.startsWith(Routes.profile))
            currentIndex = 2;

          return Scaffold(
            body: child,
            bottomNavigationBar: CustomBottomNavBar(currentIndex: currentIndex),
          );
        },
        routes: [
          GoRoute(
            path: Routes.home,
            builder: (context, state) => const UploadFilePage(),
          ),
          GoRoute(
            path: Routes.profile,
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
      GoRoute(
        path: Routes.completeProfile,
        builder: (context, state) => const MedicalInfoScreen(),
      ),
      GoRoute(
        path: Routes.editProfile,
        builder: (context, state) {
          final user = state.extra as UserModel;
          return EditProfileScreen(user: user);
        },
      ),
      GoRoute(
        path: Routes.notifications,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: Routes.help,
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: Routes.terms,
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
});
