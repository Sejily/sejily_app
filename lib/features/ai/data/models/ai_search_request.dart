import 'package:json_annotation/json_annotation.dart';

part 'ai_search_request.g.dart';

@JsonSerializable()
class AISearchRequest {
  final String question;
  final int limit;

  AISearchRequest({required this.question, required this.limit});

  factory AISearchRequest.fromJson(Map<String, dynamic> json) =>
      _$AISearchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AISearchRequestToJson(this);
}
