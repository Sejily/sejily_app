import 'package:json_annotation/json_annotation.dart';

part 'ai_search_response.g.dart';

@JsonSerializable()
class AISearchResponse {
  final bool success;
  final List<AIResult> results;
  @JsonKey(name: 'total_results')
  final int totalResults;
  final String query;

  AISearchResponse({
    required this.success,
    required this.results,
    required this.totalResults,
    required this.query,
  });

  factory AISearchResponse.fromJson(Map<String, dynamic> json) =>
      _$AISearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AISearchResponseToJson(this);
}

@JsonSerializable()
class AIResult {
  final String id;
  final String content;
  @JsonKey(name: 'relevance_score')
  final double relevanceScore;
  @JsonKey(name: 'source_file')
  final String sourceFile;
  final DateTime timestamp;

  AIResult({
    required this.id,
    required this.content,
    required this.relevanceScore,
    required this.sourceFile,
    required this.timestamp,
  });

  factory AIResult.fromJson(Map<String, dynamic> json) =>
      _$AIResultFromJson(json);

  Map<String, dynamic> toJson() => _$AIResultToJson(this);
}
