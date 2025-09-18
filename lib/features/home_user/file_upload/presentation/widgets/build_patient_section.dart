import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sejily/core/helpers/medical_translation_helper.dart';
import 'package:sejily/core/utils/app_assets.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/features/ai/data/models/ai_fhir_search_response.dart';

class BuildPatientSection extends StatelessWidget {
  const BuildPatientSection({super.key, required this.patient});
  final FhirResource patient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(Assets.profileIcon, height: 24),
              const SizedBox(width: 8),
              Text(
                'معلومات المريض',
                style: AppTextStyles.semiBold18.copyWith(
                  color: AppColors.darkBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildPatientCard(patient),
        ],
      ),
    );
  }
}

Widget _buildPatientCard(FhirResource patient) {
  final patientName = patient.name!.first.text ?? 'مريض غير محدد';

  final String? patientGender = MedicalTranslationHelper.translateGender(
    patient.gender,
  );

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.lightBlue,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.skyBlue.withValues(alpha: 0.1)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(patientName, style: AppTextStyles.semiBold18),
        if (patientGender != null) ...[
          const SizedBox(height: 6),
          Text(
            'الجنس: $patientGender',
            style: AppTextStyles.regular14.copyWith(
              color: AppColors.grayShade700,
            ),
          ),
        ],
      ],
    ),
  );
}
