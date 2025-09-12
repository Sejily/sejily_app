// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AISearchResponse _$AISearchResponseFromJson(Map<String, dynamic> json) =>
    AISearchResponse(
      success: json['success'] as bool,
      results: (json['results'] as List<dynamic>)
          .map((e) => AIResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: (json['total_results'] as num).toInt(),
      query: json['query'] as String,
    );

Map<String, dynamic> _$AISearchResponseToJson(AISearchResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'results': instance.results,
      'total_results': instance.totalResults,
      'query': instance.query,
    };

AIResult _$AIResultFromJson(Map<String, dynamic> json) => AIResult(
      id: json['id'] as String,
      content: json['content'] as String,
      relevanceScore: (json['relevance_score'] as num).toDouble(),
      sourceFile: json['source_file'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$AIResultToJson(AIResult instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'relevance_score': instance.relevanceScore,
      'source_file': instance.sourceFile,
      'timestamp': instance.timestamp.toIso8601String(),
    };
