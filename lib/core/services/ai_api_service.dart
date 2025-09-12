import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:sejily/core/constants/api_endpoints.dart';
import 'package:sejily/features/ai/data/models/ai_fhir_search_response.dart';
import 'package:sejily/features/ai/data/models/ai_search_request.dart';
import 'package:sejily/features/ai/data/models/ai_search_response.dart';
import 'package:sejily/features/ai/data/models/ai_upload_response.dart';
import 'package:sejily/features/ai/data/models/bulk_deleted_document_request.dart';
import 'package:sejily/features/ai/data/models/document_response.dart';
import 'package:sejily/features/ai/data/models/document_search_response.dart';
import 'package:sejily/features/ai/data/models/documents_response.dart';
import 'package:sejily/features/ai/data/models/documents_stats_response.dart';
import 'package:sejily/features/ai/data/models/processing_status_response.dart';

part 'ai_api_service.g.dart';

@RestApi()
abstract class AiApiService {
  factory AiApiService(Dio dio) = _AiApiService;

  //* AI
  @POST(ApiEndpoints.aiUpload)
  @MultiPart()
  Future<AIUploadResponse> uploadFile(@Part() File file);

  @POST(ApiEndpoints.aiSearch)
  Future<AISearchResponse> searchFile({
    @Body() required AISearchRequest aiSearchRequest,
  });

  @POST(ApiEndpoints.aiFhirSearch)
  Future<AIFhirSearchResponse> fhirSearchFile({@Body() required String fileId});

  @GET(
    '${ApiEndpoints.aiDocumentHead}{documentId}${ApiEndpoints.aiDocumentTail}',
  )
  Future<void> getAIDocument({@Path() required String documentId});

  @GET(ApiEndpoints.aiInsights)
  Future<void> getInsights({@Query('limit') required int limit});

  //* Document
  @GET(ApiEndpoints.documents)
  Future<DocumentsResponse> getAllDocuments();

  @GET(ApiEndpoints.documentsStats)
  Future<DocumentsStatsResponse> getDocumentsStats();

  @GET(ApiEndpoints.documentSearch)
  Future<List<DocumentSearchResponse>> searchDocuments({
    @Query('q') required String q,
    @Query('limit') int? limit,
  });

  @GET('${ApiEndpoints.documents}/{id}')
  Future<DocumentResponse> getDocument({@Path() required String id});

  @DELETE('${ApiEndpoints.documents}/{id}')
  Future<void> deleteDocument({@Path() required String id});

  @GET('${ApiEndpoints.documents}/{id}/${ApiEndpoints.processingStatus}')
  Future<ProcessingStatusResponse> getProcessingStatus({
    @Path() required String id,
  });

  @DELETE(ApiEndpoints.documentBulkDelete)
  Future<void> deleteDocuments({
    @Body() required BulkDeletedDocumentRequest bulkDeletedDocumentRequest,
  });
}
