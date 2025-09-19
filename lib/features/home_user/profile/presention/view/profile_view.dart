import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/utils/app_assets.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/features/home_user/profile/presention/widgets/warning_card.dart';
import '../manager/providers/user_provider.dart';
import '../navigation/profile_navigation.dart';
import '../widgets/logout_dialog.dart';
import '../widgets/profile_menu_item.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProfileProvider);

    return Scaffold(
      body: SafeArea(
        child: userAsync.when(
          data: (result) {
            return result.when(
              onSuccess: (user) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 45,
                        backgroundImage:
                            user.avatarUrl != null && user.avatarUrl!.isNotEmpty
                            ? NetworkImage(user.avatarUrl!)
                            : const AssetImage(Assets.selectedPerson)
                                  as ImageProvider,
                      ),

                      const SizedBox(height: 12),
                      Text(user.name, style: AppTextStyles.bold24),
                      const SizedBox(height: 4),
                      Text(user.email, style: AppTextStyles.regular14),
                      const SizedBox(height: 20),

                      WarningCard(
                        textColor: AppColors.brown,
                        bgColor: AppColors.lightOrange,
                        borderColor: AppColors.orange,
                        description: AppStrings.helpUsProvidePersonal,
                      ),

                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ProfileMenuItem(
                              icon: Assets.completePersonalInfo,
                              title: AppStrings.completeProfile,
                              onTap: () =>
                                  ProfileNavigation.goToCompleteProfile(
                                    context,
                                  ),
                            ),
                            Divider(color: AppColors.grayShade300, height: 8),
                            ProfileMenuItem(
                              icon: Assets.editPersonalInfo,
                              title: AppStrings.editProfile,
                              onTap: () => ProfileNavigation.goToEditProfile(
                                context,
                                user: user,
                              ),
                            ),
                            Divider(color: AppColors.grayShade300, height: 8),
                            ProfileMenuItem(
                              icon: Assets.emergency,
                              title: AppStrings.emergency,
                              onTap: () =>
                                  ProfileNavigation.goToEmergency(context),
                            ),
                            Divider(color: AppColors.grayShade300, height: 8),
                            ProfileMenuItem(
                              icon: Assets.notificationIcon,
                              title: AppStrings.notification,
                              onTap: () =>
                                  ProfileNavigation.goToNotifications(context),
                            ),
                            Divider(color: AppColors.grayShade300, height: 8),
                            ProfileMenuItem(
                              icon: Assets.help,
                              title: AppStrings.help,
                              onTap: () => ProfileNavigation.goToHelp(context),
                            ),
                            Divider(color: AppColors.grayShade300, height: 8),
                            ProfileMenuItem(
                              icon: Assets.terms,
                              title: AppStrings.terms,
                              onTap: () => ProfileNavigation.goToTerms(context),
                            ),
                            Divider(color: AppColors.grayShade300, height: 8),
                            ProfileMenuItem(
                              icon: Assets.logOut,
                              title: AppStrings.logout,
                              color: AppColors.red,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => const LogoutDialog(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              onFailure: (error) {
                return Center(
                  child: Text(
                    error.message ?? AppStrings.unexpectedError,
                    style: AppTextStyles.regular16.copyWith(
                      color: AppColors.red,
                    ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text(AppStrings.unexpectedError)),
        ),
      ),
    );
  }
}
