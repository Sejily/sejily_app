import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/features/ai/data/models/document_response.dart';
import 'package:sejily/features/ai/data/models/documents_response.dart';
import 'package:sejily/features/ai/presentation/manager/ai_notifier.dart';
import 'package:sejily/features/ai/presentation/pages/document_view.dart';

class UserDocumentsView extends ConsumerStatefulWidget {
  const UserDocumentsView({super.key});

  @override
  ConsumerState<UserDocumentsView> createState() => _UserDocumentsViewState();
}

class _UserDocumentsViewState extends ConsumerState<UserDocumentsView> {
  @override
  void initState() {
    super.initState();
    // Load documents when the view initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(aiNotifierProvider.notifier).getAllDocuments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(child: _buildDocumentsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.darkBlue,
            child: Icon(Icons.person, color: AppColors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ملفك الطبي',
                style: AppTextStyles.medium16.copyWith(color: AppColors.black),
              ),
              Text(
                _getCurrentDate(),
                style: AppTextStyles.regular12.copyWith(color: AppColors.gray),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColors.lightGray),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: AppColors.gray, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'بحث',
                style: AppTextStyles.regular14.copyWith(color: AppColors.gray),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentsList() {
    final documentsState = ref.watch(aiNotifierProvider);

    return documentsState.when(
      data: (data) {
        if (data is DocumentsResponse) {
          return _buildDocumentsContent(data);
        }
        return _buildEmptyState();
      },
      loading: () => _buildLoadingState(),
      error: (error, stackTrace) => _buildErrorState(error.toString()),
    );
  }

  Widget _buildDocumentsContent(DocumentsResponse documentsResponse) {
    if (documentsResponse.documents?.isEmpty ?? true) {
      return _buildEmptyState();
    }

    // Remove duplicate documents using a set-based approach
    final uniqueDocuments = _getUniqueDocuments(documentsResponse.documents!);

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: uniqueDocuments.length,
      separatorBuilder: (context, index) =>
          Divider(color: AppColors.lightGray, thickness: 1, height: 24),
      itemBuilder: (context, index) {
        final document = uniqueDocuments[index];
        return _buildDocumentCard(document);
      },
    );
  }

  Widget _buildDocumentCard(DocumentResponse document) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDate(document.uploadedAt),
                style: AppTextStyles.regular12.copyWith(color: AppColors.gray),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _getDocumentIcon(document),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        constraints: const BoxConstraints(maxHeight: 40),
                        child: _buildSafeText(
                          _getDocumentTitle(document),
                          AppTextStyles.medium14.copyWith(
                            color: AppColors.black,
                            fontFamily: 'IBM_Plex_Sans_Arabic',
                            decoration: TextDecoration.none,
                            decorationColor: Colors.transparent,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDocumentInfo(document),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _navigateToDocumentView(document),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkBlue,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                'انقر للعرض',
                style: AppTextStyles.medium14.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(child: CircularProgressIndicator(color: AppColors.darkBlue));
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: AppColors.gray),
          const SizedBox(height: 16),
          Text(
            'حدث خطأ أثناء تحميل المستندات',
            style: AppTextStyles.medium16.copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: AppTextStyles.regular12.copyWith(color: AppColors.gray),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.read(aiNotifierProvider.notifier).getAllDocuments();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkBlue,
              foregroundColor: AppColors.white,
            ),
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_open_outlined, size: 64, color: AppColors.gray),
          const SizedBox(height: 16),
          Text(
            'لا توجد مستندات',
            style: AppTextStyles.medium16.copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 8),
          Text(
            'لم يتم العثور على أي مستندات طبية',
            style: AppTextStyles.regular12.copyWith(color: AppColors.gray),
          ),
        ],
      ),
    );
  }

  void _navigateToDocumentView(DocumentResponse document) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DocumentView(document: document)),
    );
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    return '${now.year}\\${now.month}\\${now.day}';
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return '';

    try {
      final date = DateTime.parse(dateString);
      return '${date.year}\\${date.month}\\${date.day}';
    } catch (e) {
      return '';
    }
  }

  String _getDocumentTitle(DocumentResponse document) {
    try {
      return _extractDocumentTitle(document);
    } catch (e) {
      // Fallback in case of any error
      return document.fileName ?? 'مستند طبي';
    }
  }

  String _extractDocumentTitle(DocumentResponse document) {
    // Extract meaningful title from document using simplified structure
    final rawResponse = document.aiExtractedData?.rawResponse;
    if (rawResponse?.fhir != null) {
      // Try to get specific resource types
      final medicationRequests = rawResponse!.getResourcesByType(
        'MedicationRequest',
      );
      final diagnosticReports = rawResponse.getResourcesByType(
        'DiagnosticReport',
      );
      final patients = rawResponse.getResourcesByType('Patient');

      // Prioritize diagnostic reports
      if (diagnosticReports.isNotEmpty) {
        final report = diagnosticReports.first;
        if (report['code'] is Map && report['code']['text'] != null) {
          return _cleanMedicationName(report['code']['text'].toString());
        }
        return 'تقرير طبي';
      }

      // Then medication requests
      if (medicationRequests.isNotEmpty) {
        final medication = medicationRequests.first;
        if (medication['medicationCodeableConcept'] is Map) {
          final medConcept =
              medication['medicationCodeableConcept'] as Map<String, dynamic>;
          if (medConcept['text'] != null) {
            final medicationName = _cleanMedicationName(
              medConcept['text'].toString(),
            );
            return 'وصفة: $medicationName';
          }
        }
        return 'وصفة طبية';
      }

      // Then patient info
      if (patients.isNotEmpty) {
        return 'ملف مريض';
      }

      // Check extraction type for fallback
      final extractionType = document.aiExtractedData?.extractionType;
      if (extractionType != null) {
        switch (extractionType.toLowerCase()) {
          case 'prescription':
            return 'وصفة طبية';
          case 'lab_report':
            return 'تقرير مختبر';
          case 'medical_report':
            return 'تقرير طبي';
          case 'patient_record':
            return 'ملف مريض';
          default:
            return 'مستند طبي - ${_cleanMedicationName(extractionType)}';
        }
      }
    }

    // Fallback to filename or generic title
    return document.fileName ?? 'مستند طبي';
  }

  Widget _getDocumentIcon(DocumentResponse document) {
    final rawResponse = document.aiExtractedData?.rawResponse;

    // Determine icon based on resource types
    if (rawResponse?.fhir != null) {
      final medicationRequests = rawResponse!.getResourcesByType(
        'MedicationRequest',
      );
      final diagnosticReports = rawResponse.getResourcesByType(
        'DiagnosticReport',
      );
      final patients = rawResponse.getResourcesByType('Patient');

      if (diagnosticReports.isNotEmpty) {
        return Icon(Icons.assignment, color: AppColors.darkBlue, size: 20);
      } else if (medicationRequests.isNotEmpty) {
        return Icon(Icons.medication, color: AppColors.darkBlue, size: 20);
      } else if (patients.isNotEmpty) {
        return Icon(Icons.person, color: AppColors.darkBlue, size: 20);
      }
    }

    // Default folder icon
    return Icon(Icons.folder_outlined, color: AppColors.darkBlue, size: 20);
  }

  Widget _buildDocumentInfo(DocumentResponse document) {
    List<Widget> infoChips = [];

    if (document.fileSize != null) {
      infoChips.add(
        _buildInfoChip(
          Icons.storage,
          _formatFileSize(document.fileSize!),
          AppColors.skyBlue.withOpacity(0.1),
          AppColors.darkBlue,
        ),
      );
    }

    if (document.ocrConfidence != null) {
      infoChips.add(
        _buildInfoChip(
          Icons.psychology,
          '${(document.ocrConfidence! * 100).toInt()}% دقة',
          _getConfidenceColor(document.ocrConfidence!).withOpacity(0.1),
          _getConfidenceColor(document.ocrConfidence!),
        ),
      );
    }

    if (document.aiExtractedData?.extractionType != null) {
      infoChips.add(
        _buildInfoChip(
          Icons.category,
          _translateExtractionType(document.aiExtractedData!.extractionType!),
          AppColors.lightGreen.withOpacity(0.1),
          AppColors.lightGreen,
        ),
      );
    }

    if (infoChips.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 4,
          alignment: WrapAlignment.end,
          children: infoChips,
        ),
      ],
    );
  }

  Widget _buildInfoChip(
    IconData icon,
    String label,
    Color backgroundColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.regular12.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes ب';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} ك.ب';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} م.ب';
    }
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.8) {
      return AppColors.lightGreen;
    } else if (confidence >= 0.6) {
      return AppColors.skyBlue;
    } else {
      return AppColors.lightRed;
    }
  }

  String _translateExtractionType(String extractionType) {
    switch (extractionType.toLowerCase()) {
      case 'prescription':
        return 'وصفة';
      case 'lab_report':
        return 'مختبر';
      case 'medical_report':
        return 'تقرير';
      case 'patient_record':
        return 'ملف مريض';
      case 'diagnostic':
        return 'تشخيص';
      default:
        return extractionType;
    }
  }

  String _cleanMedicationName(String medicationName) {
    // Remove any special characters that might cause text rendering issues
    String cleaned = medicationName.trim();

    // Limit length to prevent UI overflow
    if (cleaned.length > 30) {
      cleaned = '${cleaned.substring(0, 27)}...';
    }

    // Replace any problematic characters
    cleaned = cleaned.replaceAll(RegExp(r'[^\w\s\u0600-\u06FF.-]'), '');

    return cleaned;
  }

  Widget _buildSafeText(String text, TextStyle style, {int maxLines = 1}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Text(
          text,
          style: style,
          overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
          textDirection: TextDirection.rtl,
          softWrap: true,
          strutStyle: const StrutStyle(forceStrutHeight: true, height: 1.4),
        );
      },
    );
  }

  /// Remove duplicate documents using set-based deduplication
  List<DocumentResponse> _getUniqueDocuments(List<DocumentResponse> documents) {
    final Set<String> seenDocuments = <String>{};
    final List<DocumentResponse> uniqueDocuments = <DocumentResponse>[];

    for (final document in documents) {
      // Create a unique identifier combining multiple fields to identify duplicates
      final uniqueKey = _createDocumentUniqueKey(document);

      // Only add if we haven't seen this document before
      if (!seenDocuments.contains(uniqueKey)) {
        seenDocuments.add(uniqueKey);
        uniqueDocuments.add(document);
      }
    }

    return uniqueDocuments;
  }

  /// Create a unique key for a document based on multiple criteria
  String _createDocumentUniqueKey(DocumentResponse document) {
    // Combine multiple fields to create a unique identifier
    final StringBuffer keyBuffer = StringBuffer();

    // Add file name (primary identifier)
    keyBuffer.write(document.fileName ?? 'unknown');
    keyBuffer.write('|');

    // Add file size for additional uniqueness
    keyBuffer.write(document.fileSize?.toString() ?? '0');
    keyBuffer.write('|');

    // Add OCR text length as content fingerprint
    final ocrLength = document.ocrText?.length ?? 0;
    keyBuffer.write(ocrLength.toString());
    keyBuffer.write('|');

    // Add extraction type for categorization
    keyBuffer.write(document.aiExtractedData?.extractionType ?? 'none');
    keyBuffer.write('|');

    // Add upload date (truncated to day) to allow same-day duplicates filtering
    final uploadDate = document.uploadedAt;
    if (uploadDate != null) {
      try {
        final date = DateTime.parse(uploadDate);
        keyBuffer.write('${date.year}-${date.month}-${date.day}');
      } catch (e) {
        keyBuffer.write('no-date');
      }
    } else {
      keyBuffer.write('no-date');
    }

    return keyBuffer.toString();
  }
}
