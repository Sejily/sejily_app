import 'package:json_annotation/json_annotation.dart';
import 'document_response.dart';

part 'documents_response.g.dart';

@JsonSerializable()
class DocumentsResponse {
  final int? total;
  final List<DocumentResponse>? documents;

  DocumentsResponse({this.total, this.documents});

  factory DocumentsResponse.fromJson(Map<String, dynamic> json) =>
      _$DocumentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentsResponseToJson(this);
}
