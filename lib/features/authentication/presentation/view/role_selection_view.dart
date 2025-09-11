import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/enums/user_role.dart';
import 'package:sejily/core/helpers/storage_extension.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/utils/app_assets.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/widgets/custom_button.dart';

class RoleSelectionView extends ConsumerStatefulWidget {
  const RoleSelectionView({super.key});

  @override
  ConsumerState<RoleSelectionView> createState() => _RoleSelectionViewState();
}

class _RoleSelectionViewState extends ConsumerState<RoleSelectionView> {
  UserRole? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                AppStrings.selectYourRole,
                style: AppTextStyles.bold24.copyWith(
                  color: AppColors.blackBlue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.chooseYourRoleTo,
                style: AppTextStyles.regular14.copyWith(color: AppColors.gray),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        //* Doctor card
                        Expanded(
                          child: RoleCard(
                            isSelected:
                                selectedRole == UserRole.healthcareProvider,
                            onTap: () => setState(
                              () => selectedRole = UserRole.healthcareProvider,
                            ),
                            selectedIcon: Image.asset(
                              Assets.selectedMedicalDoctor,
                            ),
                            unselectedIcon: Image.asset(
                              Assets.unselectedMedicalDoctor,
                            ),
                            label: AppStrings.doctor,
                          ),
                        ),
                        const SizedBox(width: 35),

                        //* Patient card
                        Expanded(
                          child: RoleCard(
                            isSelected: selectedRole == UserRole.patient,
                            onTap: () =>
                                setState(() => selectedRole = UserRole.patient),
                            selectedIcon: Image.asset(Assets.selectedPerson),
                            unselectedIcon: Image.asset(
                              Assets.unselectedPerson,
                            ),
                            label: AppStrings.user,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
                    CustomButton(
                      onPressed: selectedRole != null
                          ? _saveRoleAndNavigate
                          : null,
                      text: AppStrings.next,
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

  Future<void> _saveRoleAndNavigate() async {
    if (selectedRole == null) return;
    await storage.saveUserRole(selectedRole!);
    if (mounted) {
      context.push(Routes.register);
    }
  }
}

class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.label,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final Widget selectedIcon;
  final Widget unselectedIcon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.25,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.darkBlue : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.darkBlue, width: 1.5),
        ),
        child: LayoutBuilder(
          builder: (_, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.4,
                  child: isSelected ? selectedIcon : unselectedIcon,
                ),
                const SizedBox(height: 16),
                Text(
                  label,
                  style: AppTextStyles.medium16.copyWith(
                    color: isSelected ? AppColors.white : AppColors.jetBlack,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
