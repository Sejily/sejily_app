// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'documents_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentsResponse _$DocumentsResponseFromJson(Map<String, dynamic> json) =>
    DocumentsResponse(
      documents: (json['documents'] as List<dynamic>)
          .map((e) => Document.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      hasNext: json['hasNext'] as bool,
      hasPrev: json['hasPrev'] as bool,
    );

Map<String, dynamic> _$DocumentsResponseToJson(DocumentsResponse instance) =>
    <String, dynamic>{
      'documents': instance.documents,
      'total': instance.total,
      'page': instance.page,
      'limit': instance.limit,
      'totalPages': instance.totalPages,
      'hasNext': instance.hasNext,
      'hasPrev': instance.hasPrev,
    };
