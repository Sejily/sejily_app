// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_stats_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentsStatsResponse _$DocumentsStatsResponseFromJson(
        Map<String, dynamic> json) =>
    DocumentsStatsResponse(
      totalDocuments: (json['totalDocuments'] as num).toInt(),
      totalStorageBytes: (json['totalStorageBytes'] as num).toInt(),
      documentsByType: json['documentsByType'] as Map<String, dynamic>,
      documentsByAccessLevel:
          json['documentsByAccessLevel'] as Map<String, dynamic>,
      encryptedDocuments: (json['encryptedDocuments'] as num).toInt(),
      documentsWithOCR: (json['documentsWithOCR'] as num).toInt(),
      documentsWithAI: (json['documentsWithAI'] as num).toInt(),
      uploadActivity: (json['uploadActivity'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DocumentsStatsResponseToJson(
        DocumentsStatsResponse instance) =>
    <String, dynamic>{
      'totalDocuments': instance.totalDocuments,
      'totalStorageBytes': instance.totalStorageBytes,
      'documentsByType': instance.documentsByType,
      'documentsByAccessLevel': instance.documentsByAccessLevel,
      'encryptedDocuments': instance.encryptedDocuments,
      'documentsWithOCR': instance.documentsWithOCR,
      'documentsWithAI': instance.documentsWithAI,
      'uploadActivity': instance.uploadActivity,
    };
