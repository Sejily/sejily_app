// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_deleted_document_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkDeletedDocumentRequest _$BulkDeletedDocumentRequestFromJson(
        Map<String, dynamic> json) =>
    BulkDeletedDocumentRequest(
      documentIds: (json['documentIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$BulkDeletedDocumentRequestToJson(
        BulkDeletedDocumentRequest instance) =>
    <String, dynamic>{
      'documentIds': instance.documentIds,
    };
