import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/utils/app_assets.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/widgets/custom_app_bar.dart';
import 'package:sejily/features/ai/data/models/ai_fhir_search_response.dart';
import 'package:sejily/features/ai/presentation/manager/ai_notifier.dart';
import 'package:sejily/features/home_user/file_upload/presentation/widgets/build_medications_section.dart';
import 'package:sejily/features/home_user/file_upload/presentation/widgets/build_patient_section.dart';
import 'package:sejily/features/home_user/file_upload/presentation/widgets/fhir_state_builders.dart';

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
              backgroundColor: AppColors.redShade400,
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
          dashPattern: [10, 5],
          child: Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              Expanded(
                child: aiState.when(
                  data: (response) => _buildContent(response),
                  loading: () => const BuildLoadingState(),
                  error: (error, _) => BuildErrorState(
                    onPressed: () => ref
                        .read(aiNotifierProvider.notifier)
                        .fhirSearchFile(widget.fileId),
                  ),
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
        Align(alignment: Alignment.topLeft, child: CustomAppBar()),
        CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.grayShade500.withValues(alpha: 0.1),
          child: Image.asset(Assets.logo, height: 60),
        ),
        const SizedBox(height: 10),
        Text('تحليل المستند الطبي', style: AppTextStyles.bold20),
      ],
    );
  }

  Widget _buildContent(dynamic response) {
    if (response is! AIFhirSearchResponse || response.fhirData?.entry == null) {
      return BuildEmptyState();
    }

    final entries = response.fhirData!.entry!;
    final patient = _extractPatient(entries);
    final medications = _extractMedications(entries);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (patient != null) ...[
            BuildPatientSection(patient: patient),
            const SizedBox(height: 20),
          ],
          if (medications.isNotEmpty) ...[
            BuildMedicationsSection(medications: medications),
          ],
          if (patient == null && medications.isEmpty) BuildEmptyState(),
        ],
      ),
    );
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
