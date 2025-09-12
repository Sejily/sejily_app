import 'package:json_annotation/json_annotation.dart';

part 'document.g.dart';

@JsonSerializable()
class Document {
  final String id;
  final String userId;
  final String medicalRecordId;
  final String fileName;
  final String originalFileName;
  final int fileSize;
  final String mimeType;
  final String fileExtension;
  final String localPath;
  final String cloudUrl;
  final String ipfsHash;
  final String ocrText;
  final double ocrConfidence;
  final Map<String, dynamic> aiExtractedData;
  final bool isEncrypted;
  final String encryptionKey;
  final String accessLevel;
  final DateTime uploadedAt;
  final DateTime processedAt;

  Document({
    required this.id,
    required this.userId,
    required this.medicalRecordId,
    required this.fileName,
    required this.originalFileName,
    required this.fileSize,
    required this.mimeType,
    required this.fileExtension,
    required this.localPath,
    required this.cloudUrl,
    required this.ipfsHash,
    required this.ocrText,
    required this.ocrConfidence,
    required this.aiExtractedData,
    required this.isEncrypted,
    required this.encryptionKey,
    required this.accessLevel,
    required this.uploadedAt,
    required this.processedAt,
  });

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);
}
