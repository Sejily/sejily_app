import 'package:json_annotation/json_annotation.dart';

part 'documents_stats_response.g.dart';

@JsonSerializable()
class DocumentsStatsResponse {
  final int totalDocuments;
  final int totalStorageBytes;
  final Map<String, dynamic> documentsByType;
  final Map<String, dynamic> documentsByAccessLevel;
  final int encryptedDocuments;
  final int documentsWithOCR;
  final int documentsWithAI;
  final List<String> uploadActivity;

  DocumentsStatsResponse({
    required this.totalDocuments,
    required this.totalStorageBytes,
    required this.documentsByType,
    required this.documentsByAccessLevel,
    required this.encryptedDocuments,
    required this.documentsWithOCR,
    required this.documentsWithAI,
    required this.uploadActivity,
  });

  factory DocumentsStatsResponse.fromJson(Map<String, dynamic> json) =>
      _$DocumentsStatsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentsStatsResponseToJson(this);
}
