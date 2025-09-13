// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentResponse _$DocumentResponseFromJson(Map<String, dynamic> json) =>
    DocumentResponse(
      id: json['id'] as String?,
      fileName: json['fileName'] as String?,
      fileSize: (json['fileSize'] as num?)?.toInt(),
      mimeType: json['mimeType'] as String?,
      ocrText: json['ocrText'] as String?,
      ocrConfidence: (json['ocrConfidence'] as num?)?.toDouble(),
      aiExtractedData: json['aiExtractedData'] == null
          ? null
          : AiExtractedData.fromJson(
              json['aiExtractedData'] as Map<String, dynamic>),
      uploadedAt: json['uploadedAt'] as String?,
    );

Map<String, dynamic> _$DocumentResponseToJson(DocumentResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
      'fileSize': instance.fileSize,
      'mimeType': instance.mimeType,
      'ocrText': instance.ocrText,
      'ocrConfidence': instance.ocrConfidence,
      'aiExtractedData': instance.aiExtractedData,
      'uploadedAt': instance.uploadedAt,
    };

AiExtractedData _$AiExtractedDataFromJson(Map<String, dynamic> json) =>
    AiExtractedData(
      confidence: (json['confidence'] as num?)?.toDouble(),
      extractedAt: json['extractedAt'] as String?,
      rawResponse: json['rawResponse'] == null
          ? null
          : RawResponse.fromJson(json['rawResponse'] as Map<String, dynamic>),
      extractionType: json['extractionType'] as String?,
    );

Map<String, dynamic> _$AiExtractedDataToJson(AiExtractedData instance) =>
    <String, dynamic>{
      'confidence': instance.confidence,
      'extractedAt': instance.extractedAt,
      'rawResponse': instance.rawResponse,
      'extractionType': instance.extractionType,
    };

RawResponse _$RawResponseFromJson(Map<String, dynamic> json) => RawResponse(
      fhir: json['FHIR'] as String?,
      extractionType: json['extractionType'] as String?,
    );

Map<String, dynamic> _$RawResponseToJson(RawResponse instance) =>
    <String, dynamic>{
      'FHIR': instance.fhir,
      'extractionType': instance.extractionType,
    };
