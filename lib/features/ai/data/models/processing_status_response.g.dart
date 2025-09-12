// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'processing_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessingStatusResponse _$ProcessingStatusResponseFromJson(
        Map<String, dynamic> json) =>
    ProcessingStatusResponse(
      id: json['id'] as String,
      ocrCompleted: json['ocrCompleted'] as bool,
      aiProcessingCompleted: json['aiProcessingCompleted'] as bool,
      ocrConfidence: (json['ocrConfidence'] as num).toDouble(),
      processedAt: DateTime.parse(json['processedAt'] as String),
      errorMessage: json['errorMessage'] as String,
    );

Map<String, dynamic> _$ProcessingStatusResponseToJson(
        ProcessingStatusResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ocrCompleted': instance.ocrCompleted,
      'aiProcessingCompleted': instance.aiProcessingCompleted,
      'ocrConfidence': instance.ocrConfidence,
      'processedAt': instance.processedAt.toIso8601String(),
      'errorMessage': instance.errorMessage,
    };
