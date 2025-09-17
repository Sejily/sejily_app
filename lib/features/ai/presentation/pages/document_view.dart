import 'package:flutter/material.dart';
import 'package:sejily/core/helpers/medical_translation_helper.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/widgets/custom_app_bar.dart';
import 'package:sejily/features/ai/data/models/ai_fhir_search_response.dart';
import 'package:sejily/features/ai/data/models/document_response.dart';

class DocumentView extends StatelessWidget {
  final DocumentResponse document;

  const DocumentView({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDocumentHeader(),
            const SizedBox(height: 20),
            if (document.aiExtractedData?.rawResponse?.fhir != null) ...[
              _buildFhirSection(),
              const SizedBox(height: 20),
            ],
            _buildDocumentMetadata(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 1,
      leading: CustomAppBar(),
      title: Text(
        'تفاصيل المستند',
        style: AppTextStyles.semiBold18.copyWith(color: AppColors.black),
      ),
      centerTitle: true,
    );
  }

  Widget _buildDocumentHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.darkBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.description,
                  color: AppColors.darkBlue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document.fileName ?? 'مستند غير محدد',
                      style: AppTextStyles.semiBold18.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatFileSize(document.fileSize),
                      style: AppTextStyles.regular12.copyWith(
                        color: AppColors.grayShade500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow('نوع الملف', document.mimeType ?? 'غير محدد'),
          const SizedBox(height: 8),
          _buildInfoRow('تاريخ الرفع', _formatDate(document.uploadedAt)),
          const SizedBox(height: 8),
          _buildInfoRow(
            'تاريخ المعالجة',
            _formatDate(document.aiExtractedData?.extractedAt),
          ),
        ],
      ),
    );
  }

  Widget _buildFhirSection() {
    final rawResponse = document.aiExtractedData!.rawResponse!;
    final fhirData = rawResponse.getParsedFhirData();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.medical_information,
                color: AppColors.darkBlue,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'البيانات الطبية المستخرجة',
                style: AppTextStyles.semiBold18.copyWith(
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildConfidenceIndicator(),
          const SizedBox(height: 16),
          if (fhirData != null && fhirData.isNotEmpty) ...[
            _buildFhirEntries(fhirData, rawResponse),
          ] else ...[
            _buildNoDataMessage(),
          ],
        ],
      ),
    );
  }

  Widget _buildConfidenceIndicator() {
    final confidence = document.aiExtractedData?.confidence ?? 0.0;
    final confidencePercentage = (confidence * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _getConfidenceColor(confidence).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getConfidenceColor(confidence).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            _getConfidenceIcon(confidence),
            color: _getConfidenceColor(confidence),
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'دقة الاستخراج: $confidencePercentage%',
            style: AppTextStyles.medium14.copyWith(
              color: _getConfidenceColor(confidence),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFhirEntries(
    Map<String, dynamic> fhirData,
    RawResponse rawResponse,
  ) {
    List<Widget> entryWidgets = [];

    // Handle Bundle structure with entries
    if (fhirData['entry'] is List) {
      final entries = fhirData['entry'] as List;
      for (var entry in entries) {
        if (entry is Map<String, dynamic> &&
            entry['resource'] is Map<String, dynamic>) {
          entryWidgets.add(
            _buildFhirEntryCard(entry['resource'] as Map<String, dynamic>),
          );
        }
      }
    }
    // Handle direct array structure
    else if (fhirData['entries'] is List) {
      final entries = fhirData['entries'] as List;
      for (var entry in entries) {
        if (entry is Map<String, dynamic>) {
          entryWidgets.add(_buildFhirEntryCard(entry));
        }
      }
    }
    // Handle single resource
    else if (fhirData['resourceType'] != null) {
      entryWidgets.add(_buildFhirEntryCard(fhirData));
    }

    // If no entries found, try to get specific resource types
    if (entryWidgets.isEmpty) {
      final medicationRequests = rawResponse.getResourcesByType(
        'MedicationRequest',
      );
      final patients = rawResponse.getResourcesByType('Patient');
      final diagnosticReports = rawResponse.getResourcesByType(
        'DiagnosticReport',
      );

      for (var resource in [
        ...medicationRequests,
        ...patients,
        ...diagnosticReports,
      ]) {
        entryWidgets.add(_buildFhirEntryCard(resource));
      }
    }

    return Column(children: entryWidgets);
  }

  Widget _buildFhirEntryCard(Map<String, dynamic> resource) {
    final resourceType = resource['resourceType'] as String?;
    if (resourceType == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _getResourceIcon(resourceType),
              const SizedBox(width: 8),
              Text(
                _getResourceTitle(resourceType),
                style: AppTextStyles.semiBold18.copyWith(
                  color: AppColors.darkBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildResourceDetails(resource),
        ],
      ),
    );
  }

  Widget _buildResourceDetails(Map<String, dynamic> resource) {
    final resourceType = resource['resourceType'] as String?;
    switch (resourceType) {
      case 'Patient':
        return _buildPatientDetails(resource);
      case 'DiagnosticReport':
        return _buildDiagnosticReportDetails(resource);
      case 'MedicationRequest':
        return _buildMedicationDetails(resource);
      default:
        return _buildGenericResourceDetails(resource);
    }
  }

  Widget _buildPatientDetails(Map<String, dynamic> patient) {
    return Column(
      children: [
        if (patient['id'] != null)
          _buildDetailRow('معرف المريض', patient['id'].toString()),
        if (patient['active'] != null)
          _buildDetailRow(
            'الحالة',
            patient['active'] == true ? 'نشط' : 'غير نشط',
          ),
        if (patient['name'] is List && (patient['name'] as List).isNotEmpty)
          _buildDetailRow(
            'الاسم',
            _extractPatientName(patient['name'] as List),
          ),
        if (patient['gender'] != null)
          _buildDetailRow(
            'الجنس',
            _translateGender(patient['gender'].toString()),
          ),
      ],
    );
  }

  Widget _buildDiagnosticReportDetails(Map<String, dynamic> report) {
    return Column(
      children: [
        if (report['code'] is Map && report['code']['text'] != null)
          _buildDetailRow('نوع التقرير', report['code']['text'].toString()),
        if (report['status'] != null)
          _buildDetailRow(
            'حالة التقرير',
            _translateStatus(report['status'].toString()),
          ),
        if (report['conclusion'] != null)
          _buildDetailRow('الخلاصة', report['conclusion'].toString()),
        if (report['effectiveDateTime'] != null)
          _buildDetailRow(
            'تاريخ التقرير',
            report['effectiveDateTime'].toString(),
          ),
      ],
    );
  }

  Widget _buildMedicationDetails(Map<String, dynamic> medication) {
    return Column(
      children: [
        if (medication['status'] != null)
          _buildDetailRow(
            'الحالة',
            _translateStatus(medication['status'].toString()),
          ),
        if (medication['medicationCodeableConcept'] is Map)
          _buildMedicationInfo(
            medication['medicationCodeableConcept'] as Map<String, dynamic>,
          ),
        if (medication['dosageInstruction'] is List &&
            (medication['dosageInstruction'] as List).isNotEmpty)
          _buildDosageInfo(medication['dosageInstruction'] as List),
        if (medication['intent'] != null)
          _buildDetailRow('الغرض', medication['intent'].toString()),
      ],
    );
  }

  Widget _buildGenericResourceDetails(Map<String, dynamic> resource) {
    return Column(
      children: [
        if (resource['id'] != null)
          _buildDetailRow('المعرف', resource['id'].toString()),
        if (resource['status'] != null)
          _buildDetailRow(
            'الحالة',
            _translateStatus(resource['status'].toString()),
          ),
        if (resource['resourceType'] != null)
          _buildDetailRow('نوع المورد', resource['resourceType'].toString()),
      ],
    );
  }

  Widget _buildDocumentMetadata() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.darkBlue, size: 24),
              const SizedBox(width: 12),
              Text(
                'معلومات إضافية',
                style: AppTextStyles.semiBold18.copyWith(
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDetailRow('معرف المستند', document.id ?? 'غير محدد'),
          const SizedBox(height: 8),
          _buildDetailRow('حجم الملف', _formatFileSize(document.fileSize)),
          const SizedBox(height: 8),
          _buildDetailRow('نوع الملف', document.mimeType ?? 'غير محدد'),
          if (document.ocrText != null) ...[
            const SizedBox(height: 16),
            _buildOcrSection(),
          ],
        ],
      ),
    );
  }

  Widget _buildOcrSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'النص المستخرج (OCR)',
          style: AppTextStyles.semiBold18.copyWith(color: AppColors.darkBlue),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.lightGray),
          ),
          child: Text(
            document.ocrText!,
            style: AppTextStyles.regular12.copyWith(color: AppColors.black),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (document.ocrConfidence != null) ...[
          const SizedBox(height: 8),
          Text(
            'دقة OCR: ${(document.ocrConfidence! * 100).toInt()}%',
            style: AppTextStyles.regular12.copyWith(
              color: AppColors.grayShade500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNoDataMessage() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'لا توجد بيانات طبية مستخرجة',
          style: AppTextStyles.regular14.copyWith(
            color: AppColors.grayShade500,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            '$label:',
            style: AppTextStyles.medium14.copyWith(
              color: AppColors.grayShade500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value ?? 'غير محدد',
            style: AppTextStyles.regular12.copyWith(color: AppColors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: AppTextStyles.medium14.copyWith(
                color: AppColors.grayShade500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.regular12.copyWith(color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getResourceIcon(String? resourceType) {
    IconData iconData;
    Color color = AppColors.darkBlue;

    switch (resourceType) {
      case 'Patient':
        iconData = Icons.person;
        break;
      case 'DiagnosticReport':
        iconData = Icons.assignment;
        break;
      case 'MedicationRequest':
        iconData = Icons.medication;
        break;
      default:
        iconData = Icons.description;
    }

    return Icon(iconData, color: color, size: 20);
  }

  String _getResourceTitle(String? resourceType) {
    switch (resourceType) {
      case 'Patient':
        return 'معلومات المريض';
      case 'DiagnosticReport':
        return 'تقرير تشخيصي';
      case 'MedicationRequest':
        return 'طلب دواء';
      default:
        return resourceType ?? 'مورد غير محدد';
    }
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.8) return Colors.green;
    if (confidence >= 0.6) return AppColors.orange;
    return AppColors.red;
  }

  IconData _getConfidenceIcon(double confidence) {
    if (confidence >= 0.8) return Icons.check_circle;
    if (confidence >= 0.6) return Icons.warning;
    return Icons.error;
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'غير محدد';

    try {
      final date = DateTime.parse(dateString);
      return '${date.year}/${date.month}/${date.day} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return 'تاريخ غير صحيح';
    }
  }

  String _formatFileSize(int? bytes) {
    if (bytes == null) return 'غير محدد';

    if (bytes < 1024) return '$bytes بايت';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} كيلو بايت';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} ميجا بايت';
  }

  String _translateStatus(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return 'نشط';
      case 'final':
        return 'نهائي';
      case 'preliminary':
        return 'أولي';
      case 'cancelled':
        return 'ملغي';
      case 'completed':
        return 'مكتمل';
      default:
        return status;
    }
  }

  String _extractPatientName(List nameList) {
    if (nameList.isEmpty) return 'غير محدد';

    final name = nameList.first;
    if (name is Map<String, dynamic>) {
      final given = name['given'] as List?;
      final family = name['family'] as String?;

      String fullName = '';
      if (given != null && given.isNotEmpty) {
        fullName = given.join(' ');
      }
      if (family != null) {
        fullName = fullName.isEmpty ? family : '$fullName $family';
      }
      return fullName.isEmpty ? 'غير محدد' : fullName;
    }
    return 'غير محدد';
  }

  String _translateGender(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return 'ذكر';
      case 'female':
        return 'أنثى';
      case 'other':
        return 'آخر';
      case 'unknown':
        return 'غير معروف';
      default:
        return gender;
    }
  }

  Widget _buildMedicationInfo(Map<String, dynamic> medicationCodeableConcept) {
    final text = medicationCodeableConcept['text'] as String?;
    final coding = medicationCodeableConcept['coding'] as List?;

    if (text != null) {
      return _buildDetailRow('الدواء', text);
    } else if (coding != null && coding.isNotEmpty) {
      final firstCoding = coding.first as Map<String, dynamic>;
      final display = firstCoding['display'] as String?;
      return _buildDetailRow('الدواء', display ?? 'غير محدد');
    }
    return const SizedBox.shrink();
  }

  Widget _buildDosageInfo(List dosageInstructions) {
    if (dosageInstructions.isEmpty) return const SizedBox.shrink();

    final dosage = dosageInstructions.first as Map<String, dynamic>;
    final text = dosage['text'] as String?;

    if (text != null) {
      // Use MedicalTranslationHelper to translate dosage instructions to Arabic
      final arabicDosage = MedicalTranslationHelper.translateDosageText(text);

      // Check for timing information
      final timing = dosage['timing'] as Map<String, dynamic>?;
      String? timingText;

      if (timing != null) {
        try {
          // Create FhirTiming object from Map
          final fhirTiming = FhirTiming.fromJson(timing);
          timingText = MedicalTranslationHelper.formatTiming(fhirTiming);
        } catch (e) {
          // If timing parsing fails, ignore timing info
          timingText = null;
        }
      }

      // Combine dosage and timing if both are available
      final fullInstruction = timingText != null && timingText.isNotEmpty
          ? '$arabicDosage - $timingText'
          : arabicDosage;

      return _buildDetailRow('تعليمات الجرعة', fullInstruction);
    }
    return const SizedBox.shrink();
  }
}
