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
    final medicalInfo = ref.watch(medicalInfoProvider);

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
                  style: AppTextStyles.medium16.copyWith(color: Colors.black),
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
                  text: AppStrings.finish,
                  onPressed: () {
                    final data = ref.read(medicalInfoProvider);
                    debugPrint("Medical State: ${data.medicalState}");
                    debugPrint("Sensitive: ${data.sensitive}");
                    debugPrint("Height: ${data.height}");
                    debugPrint("Weight: ${data.weight}");
                    debugPrint("Blood Type: ${data.bloodType}");

                    Navigator.pop(context, data);
                  },
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
