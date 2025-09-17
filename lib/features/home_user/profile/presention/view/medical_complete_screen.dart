import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../manager/providers/medical_info_provider.dart';
import '../manager/providers/user_provider.dart';
import '../manager/providers/edit_profile_provider.dart';
import '../widgets/blood_type_selector.dart';
import '../widgets/medical_complete_field.dart';

class MedicalInfoScreen extends ConsumerWidget {
  const MedicalInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicalInfo = ref.watch(medicalInfoProvider);
    final editState = ref.watch(editProfileNotifierProvider);

    ref.listen<EditProfileState>(editProfileNotifierProvider, (prev, next) {
      if (next.success != null) {
        if (next.success!) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(AppStrings.savedSuccessfully)),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.errorMessage ?? AppStrings.saveFailed)),
          );
        }
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const SizedBox(height: 20),

              Text(
                AppStrings.helpUsProvidePersonal,
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.grayShade500,
                ),
              ),
              const SizedBox(height: 20),

              MedicalTextField(
                label: AppStrings.medicalState,
                initialValue: medicalInfo.medicalState,
                onChanged: (val) {
                  ref.read(medicalInfoProvider.notifier).setMedicalState(val);
                },
              ),
              const SizedBox(height: 16),

              MedicalTextField(
                label: AppStrings.sensitive,
                initialValue: medicalInfo.sensitive,
                onChanged: (val) {
                  ref.read(medicalInfoProvider.notifier).setSensitive(val);
                },
              ),
              const SizedBox(height: 16),

              MedicalTextField(
                label: AppStrings.height,
                initialValue: medicalInfo.height,
                onChanged: (val) {
                  ref.read(medicalInfoProvider.notifier).setHeight(val);
                },
              ),
              const SizedBox(height: 16),

              MedicalTextField(
                label: AppStrings.weight,
                initialValue: medicalInfo.weight,
                onChanged: (val) {
                  ref.read(medicalInfoProvider.notifier).setWeight(val);
                },
              ),
              const SizedBox(height: 24),

              Text(
                "${AppStrings.bloodType} *",
                style: AppTextStyles.medium16.copyWith(color: AppColors.black),
              ),
              const SizedBox(height: 12),

              BloodTypeSelector(
                selected: medicalInfo.bloodType,
                onChanged: (val) {
                  ref.read(medicalInfoProvider.notifier).setBloodType(val);
                },
              ),

              const SizedBox(height: 40),

              CustomButton(
                isLoading: editState.isLoading,
                text: AppStrings.finish,
                loadingText: AppStrings.savingInProgress,
                onPressed: () {
                  final userProfile = ref.read(userProfileProvider).value;

                  if (userProfile != null) {
                    userProfile.when(
                      onSuccess: (user) {
                        final updatedUser = user.copyWith(
                          bloodType: medicalInfo.bloodType,
                          height: medicalInfo.height != null
                              ? double.tryParse(medicalInfo.height!)
                              : user.height,
                          weight: medicalInfo.weight != null
                              ? double.tryParse(medicalInfo.weight!)
                              : user.weight,
                          medicalConditions: medicalInfo.medicalState != null
                              ? [medicalInfo.medicalState!]
                              : user.medicalConditions,
                          allergies: medicalInfo.sensitive != null
                              ? [medicalInfo.sensitive!]
                              : user.allergies,
                        );

                        ref
                            .read(editProfileNotifierProvider.notifier)
                            .updateProfile(updatedUser);
                      },
                      onFailure: (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.errorMessage)));
                      },
                    );
                  }
                },
                defaultSize: false,
                style: AppTextStyles.medium16.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
