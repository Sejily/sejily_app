import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';
import '../navigation/profile_navigation.dart';
import '../widgets/profile_menu_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage(
                  "assets/images/selected_person.png",
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "علي جمال",
                style: AppTextStyles.bold20.copyWith(color: AppColors.jetBlack),
              ),
              const SizedBox(height: 4),
              Text(
                "ali.gamal@gmail.com",
                style: AppTextStyles.regular14.copyWith(color: AppColors.gray),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline, color: Colors.orange),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        AppStrings.helpUsProvidePersonal,
                        style: AppTextStyles.regular14.copyWith(
                          color: Colors.brown,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    ProfileMenuItem(
                      icon: Icons.person_outline,
                      title: AppStrings.completeProfile,
                      onTap: () =>
                          ProfileNavigation.goToCompleteProfile(context),
                    ),
                    ProfileMenuItem(
                      icon: Icons.edit_outlined,
                      title: AppStrings.editProfile,
                      onTap: () => ProfileNavigation.goToEditProfile(context),
                    ),
                    ProfileMenuItem(
                      icon: Icons.groups_outlined,
                      title: AppStrings.emergency,
                      onTap: () => ProfileNavigation.goToEmergency(context),
                    ),
                    ProfileMenuItem(
                      icon: Icons.notifications_outlined,
                      title: AppStrings.notification,
                      onTap: () => ProfileNavigation.goToNotifications(context),
                    ),
                    ProfileMenuItem(
                      icon: Icons.help_outline,
                      title: AppStrings.help,
                      onTap: () => ProfileNavigation.goToHelp(context),
                    ),
                    ProfileMenuItem(
                      icon: Icons.shield_outlined,
                      title: AppStrings.terms,
                      onTap: () => ProfileNavigation.goToTerms(context),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: Text(
                        AppStrings.logout,
                        style: AppTextStyles.medium16.copyWith(
                          color: Colors.red,
                        ),
                      ),
                      onTap: () => ProfileNavigation.logout(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
