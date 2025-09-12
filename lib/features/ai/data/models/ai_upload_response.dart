import 'package:json_annotation/json_annotation.dart';

part 'ai_upload_response.g.dart';

@JsonSerializable()
class AIUploadResponse {
  final bool success;
  final String message;
  @JsonKey(name: 'file_id')
  final String fileId;
  @JsonKey(name: 'file_type')
  final String fileType;
  @JsonKey(name: 'processed_at')
  final DateTime processedAt;

  AIUploadResponse({
    required this.success,
    required this.message,
    required this.fileId,
    required this.fileType,
    required this.processedAt,
  });

  factory AIUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$AIUploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AIUploadResponseToJson(this);
}
