// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIUploadResponse _$AIUploadResponseFromJson(Map<String, dynamic> json) =>
    AIUploadResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      fileId: json['file_id'] as String,
      fileType: json['file_type'] as String,
      processedAt: DateTime.parse(json['processed_at'] as String),
    );

Map<String, dynamic> _$AIUploadResponseToJson(AIUploadResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'file_id': instance.fileId,
      'file_type': instance.fileType,
      'processed_at': instance.processedAt.toIso8601String(),
    };
