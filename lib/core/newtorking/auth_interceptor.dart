import 'dart:async';
import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/constants/api_endpoints.dart';
import 'package:sejily/core/routes/app_router.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/services/api_service.dart';
import 'package:sejily/core/services/storage/local_storage_service.dart';
import 'package:sejily/features/authentication/data/repository/auth_repository.dart';

class AuthInterceptor extends Interceptor {
  final Ref ref;

  final Queue<RequestOptions> _requestQueue = Queue<RequestOptions>();
  final Queue<Completer<Response>> _completerQueue =
      Queue<Completer<Response>>();

  bool _isRefreshing = false;

  AuthInterceptor(this.ref);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path.contains(ApiEndpoints.refreshToken)) {
      handler.next(options);
      return;
    }

    final accessToken = await ref.read(storageServiceProvider).getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401 && err.response?.statusCode != 403) {
      handler.next(err);
      return;
    }

    try {
      final refreshToken = await ref
          .read(storageServiceProvider)
          .getRefreshToken();

      if (refreshToken == null) {
        await _clearStorageAndNavigateToLogin();
        handler.next(err);
        return;
      }

      // If already refreshing, queue the request
      if (_isRefreshing) {
        final completer = Completer<Response>();
        _requestQueue.add(err.requestOptions);
        _completerQueue.add(completer);

        try {
          final response = await completer.future;
          handler.resolve(response);
        } catch (e) {
          handler.next(err);
        }
        return;
      }

      // Start refresh process
      _isRefreshing = true;
      final authRepository = ref.read(authRepositoryProvider);

      final refreshResult = await authRepository.refreshToken(
        refreshToken: refreshToken,
      );

      await refreshResult.when(
        onSuccess: (tokensModel) async {
          // Save new tokens
          await ref
              .read(storageServiceProvider)
              .saveTokens(
                accessToken: tokensModel.accessToken,
                refreshToken: tokensModel.refreshToken,
              );

          // Retry original request with new token
          final response = await _retryRequest(
            err.requestOptions,
            tokensModel.accessToken,
          );
          handler.resolve(response);

          // Process queued requests
          await _processQueuedRequests(tokensModel.accessToken);
        },
        onFailure: (apiError) async {
          // Refresh failed, clear storage and navigate to login
          await _clearStorageAndNavigateToLogin();

          // Fail all queued requests
          _failQueuedRequests(err);

          handler.next(err);
        },
      );
    } catch (e) {
      await _clearStorageAndNavigateToLogin();
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<Response> _retryRequest(
    RequestOptions options,
    String accessToken,
  ) async {
    options.headers['Authorization'] = 'Bearer $accessToken';
    final dio = ref.read(dioProvider);
    return await dio.fetch(options);
  }

  Future<void> _processQueuedRequests(String accessToken) async {
    while (_requestQueue.isNotEmpty && _completerQueue.isNotEmpty) {
      final request = _requestQueue.removeFirst();
      final completer = _completerQueue.removeFirst();

      try {
        final response = await _retryRequest(request, accessToken);
        completer.complete(response);
      } catch (e) {
        completer.completeError(e);
      }
    }
  }

  void _failQueuedRequests(DioException originalError) {
    while (_completerQueue.isNotEmpty) {
      final completer = _completerQueue.removeFirst();
      completer.completeError(originalError);
    }
    _requestQueue.clear();
  }

  Future<void> _clearStorageAndNavigateToLogin() async {
    await ref.read(storageServiceProvider).clearTokens();
    ref.read(routerProvider).go(Routes.login);
  }
}
