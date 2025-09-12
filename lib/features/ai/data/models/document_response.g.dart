// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentResponse _$DocumentResponseFromJson(Map<String, dynamic> json) =>
    DocumentResponse(
      id: json['id'] as String,
      userId: json['userId'] as String,
      medicalRecordId: json['medicalRecordId'] as String,
      fileName: json['fileName'] as String,
      originalFileName: json['originalFileName'] as String,
      fileSize: (json['fileSize'] as num).toInt(),
      mimeType: json['mimeType'] as String,
      fileExtension: json['fileExtension'] as String,
      localPath: json['localPath'] as String,
      cloudUrl: json['cloudUrl'] as String,
      ipfsHash: json['ipfsHash'] as String,
      ocrText: json['ocrText'] as String,
      ocrConfidence: (json['ocrConfidence'] as num).toDouble(),
      aiExtractedData: json['aiExtractedData'] as Map<String, dynamic>,
      isEncrypted: json['isEncrypted'] as bool,
      encryptionKey: json['encryptionKey'] as String,
      accessLevel: json['accessLevel'] as String,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      processedAt: DateTime.parse(json['processedAt'] as String),
    );

Map<String, dynamic> _$DocumentResponseToJson(DocumentResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'medicalRecordId': instance.medicalRecordId,
      'fileName': instance.fileName,
      'originalFileName': instance.originalFileName,
      'fileSize': instance.fileSize,
      'mimeType': instance.mimeType,
      'fileExtension': instance.fileExtension,
      'localPath': instance.localPath,
      'cloudUrl': instance.cloudUrl,
      'ipfsHash': instance.ipfsHash,
      'ocrText': instance.ocrText,
      'ocrConfidence': instance.ocrConfidence,
      'aiExtractedData': instance.aiExtractedData,
      'isEncrypted': instance.isEncrypted,
      'encryptionKey': instance.encryptionKey,
      'accessLevel': instance.accessLevel,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
      'processedAt': instance.processedAt.toIso8601String(),
    };
