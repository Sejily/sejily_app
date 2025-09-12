import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/features/ai/data/models/ai_search_request.dart';
import 'package:sejily/features/ai/data/models/bulk_deleted_document_request.dart';
import 'package:sejily/features/ai/data/repository/ai_repository.dart';

final aiNotifierProvider =
    StateNotifierProvider<AiNotifier, AsyncValue<dynamic>>((ref) {
      final repository = ref.watch(aiRepositoryProvider);
      return AiNotifier(repository);
    });

class AiNotifier extends StateNotifier<AsyncValue<dynamic>> {
  final AiRepository _repository;

  AiNotifier(this._repository) : super(const AsyncValue.loading());

  //* AI
  Future<void> uploadFile(dynamic file) async {
    state = const AsyncValue.loading();
    final result = await _repository.uploadFile(file);
    result.when(
      onSuccess: (data) => state = AsyncValue.data(data),
      onFailure: (error) =>
          state = AsyncValue.error(error.errorMessage, StackTrace.current),
    );
  }

  Future<void> searchFile(AISearchRequest request) async {
    state = const AsyncValue.loading();
    final result = await _repository.searchFile(request);
    result.when(
      onSuccess: (data) => state = AsyncValue.data(data),
      onFailure: (error) =>
          state = AsyncValue.error(error.errorMessage, StackTrace.current),
    );
  }

  Future<void> fhirSearchFile(String fileId) async {
    state = const AsyncValue.loading();
    final result = await _repository.fhirSearchFile(fileId);
    result.when(
      onSuccess: (data) => state = AsyncValue.data(data),
      onFailure: (error) =>
          state = AsyncValue.error(error.errorMessage, StackTrace.current),
    );
  }

  Future<void> getAIDocument(String documentId) async {
    state = const AsyncValue.loading();
    final result = await _repository.getAIDocument(documentId);
    result.when(
      onSuccess: (_) => state = const AsyncValue.data(null),
      onFailure: (error) =>
          state = AsyncValue.error(error.errorMessage, StackTrace.current),
    );
  }

  Future<void> getInsights(int limit) async {
    state = const AsyncValue.loading();
    final result = await _repository.getInsights(limit);
    result.when(
      onSuccess: (data) => state = AsyncValue.data(null),
      onFailure: (error) =>
          state = AsyncValue.error(error.errorMessage, StackTrace.current),
    );
  }

  //* Documents
  Future<void> getAllDocuments() async {
    state = const AsyncValue.loading();
    final result = await _repository.getAllDocuments();
    result.when(
      onSuccess: (data) => state = AsyncValue.data(data),
      onFailure: (error) =>
          state = AsyncValue.error(error.errorMessage, StackTrace.current),
    );
  }

  Future<void> getDocumentsStats() async {
    state = const AsyncValue.loading();
    final result = await _repository.getDocumentsStats();
    result.when(
      onSuccess: (data) => state = AsyncValue.data(data),
      onFailure: (error) =>
          state = AsyncValue.error(error.errorMessage, StackTrace.current),
    );
  }

  Future<void> searchDocuments(String query, {int? limit}) async {
    state = const AsyncValue.loading();
    final result = await _repository.searchDocuments(
      query: query,
      limit: limit,
    );
    result.when(
      onSuccess: (data) => state = AsyncValue.data(data),
      onFailure: (error) =>
          state = AsyncValue.error(error.errorMessage, StackTrace.current),
    );
  }

  Future<void> getDocument(String id) async {
    state = const AsyncValue.loading();
    final result = await _repository.getDocument(id);
    result.when(
      onSuccess: (data) => state = AsyncValue.data(data),
      onFailure: (error) =>
          state = AsyncValue.error(error.errorMessage, StackTrace.current),
    );
  }

  Future<void> deleteDocument(String id) async {
    state = const AsyncValue.loading();
    final result = await _repository.deleteDocument(id);
    result.when(
      onSuccess: (_) => state = const AsyncValue.data(null),
      onFailure: (error) =>
          state = AsyncValue.error(error.errorMessage, StackTrace.current),
    );
  }

  Future<void> getProcessingStatus(String id) async {
    state = const AsyncValue.loading();
    final result = await _repository.getProcessingStatus(id);
    result.when(
      onSuccess: (data) => state = AsyncValue.data(data),
      onFailure: (error) =>
          state = AsyncValue.error(error.errorMessage, StackTrace.current),
    );
  }

  Future<void> deleteDocuments(BulkDeletedDocumentRequest request) async {
    state = const AsyncValue.loading();
    final result = await _repository.deleteDocuments(request);
    result.when(
      onSuccess: (_) => state = const AsyncValue.data(null),
      onFailure: (error) =>
          state = AsyncValue.error(error.errorMessage, StackTrace.current),
    );
  }
}
