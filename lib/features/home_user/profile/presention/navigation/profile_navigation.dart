import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/routes/routes.dart';
import '../../../../../core/services/secure_storage_service.dart';
import '../../data/models/user_model.dart';
import '../view/edit_profile_view.dart';

class ProfileNavigation {
  static void goToCompleteProfile(BuildContext context) {
    context.push(Routes.completeProfile);
  }

  static void goToEditProfile(BuildContext context, {required UserModel user}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditProfileScreen()),
    );
  }

  static void goToEmergency(BuildContext context) {
    context.push(Routes.userProfileEmergencyContacts);
  }

  static void goToNotifications(BuildContext context) {
    context.push(Routes.notifications);
  }

  static void goToHelp(BuildContext context) {
    context.push(Routes.help);
  }

  static void goToTerms(BuildContext context) {
    context.push(Routes.terms);
  }

  static Future<void> logoutWithRouter(GoRouter router) async {
    try {
      await StorageService.instance.clearLoginData();
      router.go(Routes.login);
    } catch (e) {
      router.go(Routes.login);
    }
  }
}
