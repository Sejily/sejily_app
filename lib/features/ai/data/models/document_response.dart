import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'document_response.g.dart';

@JsonSerializable()
class DocumentResponse {
  final String? id;
  @JsonKey(name: 'fileName')
  final String? fileName;
  @JsonKey(name: 'fileSize')
  final int? fileSize;
  @JsonKey(name: 'mimeType')
  final String? mimeType;
  @JsonKey(name: 'ocrText')
  final String? ocrText;
  @JsonKey(name: 'ocrConfidence')
  final double? ocrConfidence;
  @JsonKey(name: 'aiExtractedData')
  final AiExtractedData? aiExtractedData;
  @JsonKey(name: 'uploadedAt')
  final String? uploadedAt;

  DocumentResponse({
    this.id,
    this.fileName,
    this.fileSize,
    this.mimeType,
    this.ocrText,
    this.ocrConfidence,
    this.aiExtractedData,
    this.uploadedAt,
  });

  factory DocumentResponse.fromJson(Map<String, dynamic> json) =>
      _$DocumentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentResponseToJson(this);
}

@JsonSerializable()
class AiExtractedData {
  final double? confidence;
  @JsonKey(name: 'extractedAt')
  final String? extractedAt;
  @JsonKey(name: 'rawResponse')
  final RawResponse? rawResponse;
  @JsonKey(name: 'extractionType')
  final String? extractionType;

  AiExtractedData({
    this.confidence,
    this.extractedAt,
    this.rawResponse,
    this.extractionType,
  });

  factory AiExtractedData.fromJson(Map<String, dynamic> json) =>
      _$AiExtractedDataFromJson(json);

  Map<String, dynamic> toJson() => _$AiExtractedDataToJson(this);
}

@JsonSerializable()
class RawResponse {
  @JsonKey(name: 'FHIR')
  final String? fhir;
  @JsonKey(name: 'extractionType')
  final String? extractionType;

  RawResponse({this.fhir, this.extractionType});

  factory RawResponse.fromJson(Map<String, dynamic> json) =>
      _$RawResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RawResponseToJson(this);

  /// Safely parse FHIR data as a Map to avoid conflicts with nested structures
  Map<String, dynamic>? getParsedFhirData() {
    if (fhir == null || fhir!.isEmpty) return null;

    try {
      // Remove markdown code block markers if present
      String cleanFhir = getCleanFhirString() ?? '';
      if (cleanFhir.isEmpty) return null;

      // Parse as dynamic first, then safely cast
      final dynamic parsedData = jsonDecode(cleanFhir);

      // Handle both object {} and array [] responses safely
      if (parsedData is Map<String, dynamic>) {
        return parsedData;
      } else if (parsedData is List) {
        // If it's an array, wrap it in a map for consistent handling
        return {'entries': parsedData};
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Get the raw FHIR string without markdown formatting
  String? getCleanFhirString() {
    if (fhir == null || fhir!.isEmpty) return null;

    String cleanFhir = fhir!.trim();

    // Remove markdown code block markers
    if (cleanFhir.startsWith('```json')) {
      final startIndex = cleanFhir.indexOf('\n') + 1;
      if (startIndex > 0 && startIndex < cleanFhir.length) {
        cleanFhir = cleanFhir.substring(startIndex);
      }
    }
    if (cleanFhir.endsWith('```')) {
      cleanFhir = cleanFhir.substring(0, cleanFhir.length - 3);
    }

    return cleanFhir.trim();
  }

  /// Extract specific FHIR resource types safely
  List<Map<String, dynamic>> getResourcesByType(String resourceType) {
    final parsedData = getParsedFhirData();
    if (parsedData == null) return [];

    List<Map<String, dynamic>> resources = [];

    // Handle Bundle structure
    if (parsedData['entry'] is List) {
      for (var entry in parsedData['entry'] as List) {
        if (entry is Map<String, dynamic> &&
            entry['resource'] is Map<String, dynamic>) {
          final resource = entry['resource'] as Map<String, dynamic>;
          if (resource['resourceType'] == resourceType) {
            resources.add(resource);
          }
        }
      }
    }
    // Handle direct array of resources
    else if (parsedData['entries'] is List) {
      for (var item in parsedData['entries'] as List) {
        if (item is Map<String, dynamic> &&
            item['resourceType'] == resourceType) {
          resources.add(item);
        }
      }
    }
    // Handle single resource
    else if (parsedData['resourceType'] == resourceType) {
      resources.add(parsedData);
    }
    return resources;
  }
}
