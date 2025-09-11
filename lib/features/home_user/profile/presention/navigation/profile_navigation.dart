import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/routes/routes.dart';

class ProfileNavigation {
  static void goToCompleteProfile(BuildContext context) {
    context.push(Routes.completeProfile);
  }

  static void goToEditProfile(BuildContext context) {
    context.push(Routes.editProfile);
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

  static void logout(BuildContext context) {
    context.push(Routes.login);
  }
}
