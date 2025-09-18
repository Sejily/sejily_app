import 'package:flutter/material.dart';
import 'package:sejily/core/helpers/medical_translation_helper.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/features/ai/data/models/ai_fhir_search_response.dart';

class BuildMedicationsSection extends StatelessWidget {
  const BuildMedicationsSection({super.key, required this.medications});
  final List<FhirResource> medications;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.medication_outlined,
                size: 24,
                color: AppColors.darkBlue,
              ),
              const SizedBox(width: 8),
              Text(
                'الأدوية المصروفة',
                style: AppTextStyles.semiBold18.copyWith(
                  color: AppColors.darkBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...medications.asMap().entries.map((entry) {
            final index = entry.key;
            final medication = entry.value;
            return Padding(
              padding: EdgeInsets.only(
                bottom: index < medications.length - 1 ? 12 : 0,
              ),
              child: _buildMedicationCard(medication),
            );
          }),
        ],
      ),
    );
  }
}

Widget _buildMedicationCard(FhirResource medication) {
  final medicationName =
      medication.medicationCodeableConcept?.text ?? 'دواء غير محدد';

  final dosage = MedicalTranslationHelper.translateDosageText(
    medication.dosageInstruction!.first.text ?? 'الجرعة غير محددة',
  );

  final timing = MedicalTranslationHelper.formatTiming(
    medication.dosageInstruction!.first.timing!,
  );

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.lightBlue,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.blueShade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          medicationName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Text(
          dosage,
          style: AppTextStyles.regular14.copyWith(
            color: AppColors.grayShade700,
          ),
        ),
        if (timing != null) ...[
          const SizedBox(height: 4),
          Text(
            timing,
            style: AppTextStyles.regular12.copyWith(
              color: AppColors.grayShade600,
            ),
          ),
        ],
      ],
    ),
  );
}
