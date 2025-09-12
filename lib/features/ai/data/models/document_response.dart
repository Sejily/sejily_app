import 'package:json_annotation/json_annotation.dart';
import 'document.dart';

part 'document_response.g.dart';

@JsonSerializable()
class DocumentResponse extends Document {
  DocumentResponse({
    required super.id,
    required super.userId,
    required super.medicalRecordId,
    required super.fileName,
    required super.originalFileName,
    required super.fileSize,
    required super.mimeType,
    required super.fileExtension,
    required super.localPath,
    required super.cloudUrl,
    required super.ipfsHash,
    required super.ocrText,
    required super.ocrConfidence,
    required super.aiExtractedData,
    required super.isEncrypted,
    required super.encryptionKey,
    required super.accessLevel,
    required super.uploadedAt,
    required super.processedAt,
  });

  factory DocumentResponse.fromJson(Map<String, dynamic> json) =>
      _$DocumentResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DocumentResponseToJson(this);
}
