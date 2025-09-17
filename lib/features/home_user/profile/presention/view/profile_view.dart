import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';
import '../manager/providers/user_provider.dart';
import '../navigation/profile_navigation.dart';
import '../widgets/logout_dialog.dart';
import '../widgets/profile_menu_item.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProfileProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.white,
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
                              user.avatarUrl != null &&
                                  user.avatarUrl!.isNotEmpty
                              ? NetworkImage(user.avatarUrl!)
                              : const AssetImage(
                                      "assets/images/selected_person.png",
                                    )
                                    as ImageProvider,
                        ),

                        const SizedBox(height: 12),
                        Text(
                          user.name,
                          style: AppTextStyles.bold20.copyWith(
                            color: AppColors.jetBlack,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          user.email,
                          style: AppTextStyles.regular14.copyWith(
                            color: AppColors.grayShade500,
                          ),
                        ),

                        const SizedBox(height: 12),

                        if (user.phone != null && user.phone!.isNotEmpty)
                          Text(" ${user.phone}"),
                        if (user.city != null && user.city!.isNotEmpty)
                          Text(" ${user.city}"),
                        if (user.address != null && user.address!.isNotEmpty)
                          Text(" ${user.address}"),
                        if (user.bloodType != null &&
                            user.bloodType!.isNotEmpty)
                          Text("${AppStrings.bloodTypeLabel}${user.bloodType}"),
                        if (user.height != null)
                          Text("${AppStrings.heightLabel}${user.height}"),
                        if (user.weight != null)
                          Text("${AppStrings.weightLabel}${user.weight}"),

                        const SizedBox(height: 20),

                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8E1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.amber),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: AppColors.orange,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  AppStrings.helpUsProvidePersonal,
                                  style: AppTextStyles.regular14.copyWith(
                                    color: AppColors.brown,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                        ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            ProfileMenuItem(
                              icon: Icons.person_outline,
                              title: AppStrings.completeProfile,
                              onTap: () =>
                                  ProfileNavigation.goToCompleteProfile(
                                    context,
                                  ),
                            ),
                            ProfileMenuItem(
                              icon: Icons.edit_outlined,
                              title: AppStrings.editProfile,
                              onTap: () {
                                ProfileNavigation.goToEditProfile(
                                  context,
                                  user: user,
                                );
                              },
                            ),
                            ProfileMenuItem(
                              icon: Icons.groups_outlined,
                              title: AppStrings.emergency,
                              onTap: () =>
                                  ProfileNavigation.goToEmergency(context),
                            ),
                            ProfileMenuItem(
                              icon: Icons.notifications_outlined,
                              title: AppStrings.notification,
                              onTap: () =>
                                  ProfileNavigation.goToNotifications(context),
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
                              leading: const Icon(
                                Icons.logout,
                                color: AppColors.red,
                              ),
                              title: Text(
                                AppStrings.logout,
                                style: AppTextStyles.medium16.copyWith(
                                  color: AppColors.red,
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => const LogoutDialog(),
                                );
                              },
                            ),
                          ],
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
      ),
    );
  }
}
