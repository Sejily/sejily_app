import 'package:json_annotation/json_annotation.dart';
import 'document.dart';

part 'documents_response.g.dart';

@JsonSerializable()
class DocumentsResponse {
  final List<Document> documents;
  final int total;
  final int page;
  final int limit;
  final int totalPages;
  final bool hasNext;
  final bool hasPrev;

  DocumentsResponse({
    required this.documents,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrev,
  });

  factory DocumentsResponse.fromJson(Map<String, dynamic> json) =>
      _$DocumentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentsResponseToJson(this);
}
