import 'package:json_annotation/json_annotation.dart';

part 'processing_status_response.g.dart';

@JsonSerializable()
class ProcessingStatusResponse {
  final String id;
  final bool ocrCompleted;
  final bool aiProcessingCompleted;
  final double ocrConfidence;
  final DateTime processedAt;
  final String errorMessage;

  ProcessingStatusResponse({
    required this.id,
    required this.ocrCompleted,
    required this.aiProcessingCompleted,
    required this.ocrConfidence,
    required this.processedAt,
    required this.errorMessage,
  });

  factory ProcessingStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$ProcessingStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessingStatusResponseToJson(this);
}
