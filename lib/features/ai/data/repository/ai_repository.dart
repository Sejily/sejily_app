import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/newtorking/api_error_handler.dart';
import 'package:sejily/core/newtorking/api_result.dart';
import 'package:sejily/core/services/ai_api_service.dart';
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

final aiRepositoryProvider = Provider<AiRepository>((ref) {
  final api = ref.watch(aiApiServiceProvider);
  return AiRepository(api);
});

class AiRepository {
  final AiApiService _api;

  AiRepository(this._api);

  //* AI
  Future<ApiResult<AIUploadResponse>> uploadFile(File file) async {
    try {
      final result = await _api.uploadFile(file);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<AISearchResponse>> searchFile(
    AISearchRequest request,
  ) async {
    try {
      final result = await _api.searchFile(aiSearchRequest: request);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<AIFhirSearchResponse>> fhirSearchFile(String fileId) async {
    try {
      final result = await _api.fhirSearchFile(fileId: fileId);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<void>> getAIDocument(String documentId) async {
    try {
      await _api.getAIDocument(documentId: documentId);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<void>> getInsights(int limit) async {
    try {
      await _api.getInsights(limit: limit);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  //* Documents
  Future<ApiResult<DocumentsResponse>> getAllDocuments() async {
    try {
      final result = await _api.getAllDocuments();
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DocumentsStatsResponse>> getDocumentsStats() async {
    try {
      final result = await _api.getDocumentsStats();
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<List<DocumentSearchResponse>>> searchDocuments({
    required String query,
    int? limit,
  }) async {
    try {
      final response = await _api.searchDocuments(q: query, limit: limit);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<DocumentResponse>> getDocument(String id) async {
    try {
      final result = await _api.getDocument(id: id);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<void>> deleteDocument(String id) async {
    try {
      await _api.deleteDocument(id: id);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<ProcessingStatusResponse>> getProcessingStatus(
    String id,
  ) async {
    try {
      final result = await _api.getProcessingStatus(id: id);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<void>> deleteDocuments(
    BulkDeletedDocumentRequest request,
  ) async {
    try {
      await _api.deleteDocuments(bulkDeletedDocumentRequest: request);
      return ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
