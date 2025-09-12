// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_search_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AISearchRequest _$AISearchRequestFromJson(Map<String, dynamic> json) =>
    AISearchRequest(
      question: json['question'] as String,
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$AISearchRequestToJson(AISearchRequest instance) =>
    <String, dynamic>{
      'question': instance.question,
      'limit': instance.limit,
    };
