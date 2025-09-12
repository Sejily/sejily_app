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
      MaterialPageRoute(builder: (_) => EditProfileScreen(user: user)),
    );
  }

  static void goToEmergency(BuildContext context) {
    context.push(Routes.emergencyContact);
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

  static void logout(BuildContext context) async {
    await StorageService.instance.clearLoginData();
    GoRouter.of(context).go(Routes.login);
  }
}
