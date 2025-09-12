import 'package:json_annotation/json_annotation.dart';

part 'bulk_deleted_document_request.g.dart';

@JsonSerializable()
class BulkDeletedDocumentRequest {
  final List<String> documentIds;

  BulkDeletedDocumentRequest({required this.documentIds});

  factory BulkDeletedDocumentRequest.fromJson(Map<String, dynamic> json) =>
      _$BulkDeletedDocumentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BulkDeletedDocumentRequestToJson(this);
}
