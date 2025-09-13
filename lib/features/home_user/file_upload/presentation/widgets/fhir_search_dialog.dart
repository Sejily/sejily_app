import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/utils/app_assets.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/helpers/medical_translation_helper.dart';
import 'package:sejily/features/ai/data/models/ai_fhir_search_response.dart';
import 'package:sejily/features/ai/presentation/manager/ai_notifier.dart';

class FhirSearchDialog extends ConsumerStatefulWidget {
  final String fileId;

  const FhirSearchDialog({super.key, required this.fileId});

  @override
  ConsumerState<FhirSearchDialog> createState() => _FhirSearchDialogState();
}

class _FhirSearchDialogState extends ConsumerState<FhirSearchDialog> {
  @override
  void initState() {
    super.initState();
    // Automatically load FHIR data when dialog opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(aiNotifierProvider.notifier).fhirSearchFile(widget.fileId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Listen to state changes for error/success handling
    ref.listen<AsyncValue<dynamic>>(aiNotifierProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('خطأ في تحميل البيانات: $error'),
              backgroundColor: Colors.red.shade400,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      );
    });

    final aiState = ref.watch(aiNotifierProvider);

    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.95,
        height: MediaQuery.sizeOf(context).height * 0.85,
        padding: const EdgeInsets.all(16),
        child: DottedBorder(
          color: AppColors.darkBlue,
          strokeWidth: 2.5,
          borderType: BorderType.RRect,
          child: Column(
            children: [
              Expanded(
                child: aiState.when(
                  data: (response) => _buildContent(response),
                  loading: () => _buildLoadingState(),
                  error: (error, stack) => _buildErrorState(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Align(
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ),
        CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.gray.withValues(alpha: 0.1),
          child: Image.asset(Assets.logo, height: 80),
        ),
        const SizedBox(height: 10),
        Text(
          'تحليل المستند الطبي',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.blue.shade400,
            strokeWidth: 3,
          ),
          const SizedBox(height: 16),
          Text(
            'جاري تحليل المستند الطبي...',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'حدث خطأ أثناء تحليل المستند',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'يرجى المحاولة مرة أخرى',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              ref
                  .read(aiNotifierProvider.notifier)
                  .fhirSearchFile(widget.fileId);
            },
            icon: const Icon(Icons.refresh_rounded, size: 20),
            label: const Text('إعادة المحاولة'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade50,
              foregroundColor: Colors.blue.shade700,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(dynamic response) {
    if (response is! AIFhirSearchResponse || response.fhirData?.entry == null) {
      return _buildEmptyState();
    }

    final entries = response.fhirData!.entry!;
    final patient = _extractPatient(entries);
    final medications = _extractMedications(entries);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          if (patient != null) ...[
            _buildPatientSection(patient),
            const SizedBox(height: 20),
          ],
          if (medications.isNotEmpty) ...[
            _buildMedicationsSection(medications),
          ],
          if (patient == null && medications.isEmpty) _buildEmptyState(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description_outlined,
            size: 64,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد بيانات طبية للعرض',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'المستند لا يحتوي على معلومات طبية قابلة للاستخراج',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPatientSection(FhirResource patient) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person_outline, color: AppColors.darkBlue, size: 24),
              const SizedBox(width: 8),
              Text(
                'معلومات المريض',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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

  Widget _buildPatientCard(FhirResource patient) {
    final patientName = patient.name?.isNotEmpty == true
        ? _formatName(patient.name!.first)
        : 'مريض غير محدد';

    final patientGender = patient.gender != null
        ? MedicalTranslationHelper.translateGender(patient.gender!)
        : null;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            patientName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          if (patientGender != null) ...[
            const SizedBox(height: 6),
            Text(
              'الجنس: $patientGender',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMedicationsSection(List<FhirResource> medications) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.medication_outlined,
                color: AppColors.darkBlue,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'الأدوية المصروفة',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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

  Widget _buildMedicationCard(FhirResource medication) {
    final medicationName =
        medication.medicationCodeableConcept?.text ?? 'دواء غير محدد';

    final dosage = medication.dosageInstruction?.isNotEmpty == true
        ? MedicalTranslationHelper.translateDosageText(
            medication.dosageInstruction!.first.text ?? 'الجرعة غير محددة',
          )
        : 'الجرعة غير محددة';

    final timing =
        medication.dosageInstruction?.isNotEmpty == true &&
            medication.dosageInstruction!.first.timing != null
        ? MedicalTranslationHelper.formatTiming(
            medication.dosageInstruction!.first.timing!,
          )
        : null;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
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
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
          if (timing != null) ...[
            const SizedBox(height: 4),
            Text(
              timing,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatName(FhirName name) {
    return name.text ?? 'غير محدد';
  }

  FhirResource? _extractPatient(List<FhirEntry> entries) {
    for (final entry in entries) {
      if (entry.resource?.resourceType == 'Patient') {
        return entry.resource;
      }
    }
    return null;
  }

  List<FhirResource> _extractMedications(List<FhirEntry> entries) {
    return entries
        .where((entry) => entry.resource?.resourceType == 'MedicationRequest')
        .map((entry) => entry.resource!)
        .toList();
  }
}
