import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../manager/providers/medical_info_provider.dart';
import '../widgets/blood_type_selector.dart';
import '../widgets/medical_complete_field.dart';

class MedicalInfoScreen extends ConsumerWidget {
  const MedicalInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloodType = ref.watch(medicalInfoProvider).bloodType;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.white,
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
                  style: AppTextStyles.regular14.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 20),

                const MedicalTextField(label: AppStrings.medicalState),
                const SizedBox(height: 16),
                const MedicalTextField(label: AppStrings.sensitive),
                const SizedBox(height: 16),
                const MedicalTextField(label: AppStrings.height),
                const SizedBox(height: 16),
                const MedicalTextField(label: AppStrings.weight),
                const SizedBox(height: 24),

                Text(
                  "${AppStrings.bloodType} *",
                  style: AppTextStyles.medium16.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 12),

                BloodTypeSelector(
                  selected: bloodType,
                  onChanged: (val) {
                    ref.read(medicalInfoProvider.notifier).setBloodType(val);
                  },
                ),

                const SizedBox(height: 40),
                CustomButton(
                  text: AppStrings.finish,
                  onPressed: () {},
                  backgroundColor: AppColors.darkBlue,
                  foregroundColor: AppColors.white,
                  defaultSize: false,
                  style: AppTextStyles.medium16.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
