import 'dart:async';
import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/constants/api_endpoints.dart';
import 'package:sejily/core/constants/app_constants.dart';
import 'package:sejily/core/helpers/storage_extension.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/features/authentication/data/models/tokens_model.dart';

class AuthInterceptor extends Interceptor {
  final String baseUrl;
  final GoRouter _router;

  final Queue<RequestOptions> _requestQueue = Queue<RequestOptions>();
  final Queue<Completer<Response>> _completerQueue =
      Queue<Completer<Response>>();

  bool _isRefreshing = false;
  Dio? _refreshDio;

  AuthInterceptor(this.baseUrl, this._router);

  // Create a separate Dio instance for refresh token requests to avoid circular dependency
  Dio get refreshDio {
    _refreshDio ??= Dio(BaseOptions(baseUrl: baseUrl));
    return _refreshDio!;
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    List<String> requests = [
      ApiEndpoints.refreshToken,
      ApiEndpoints.register,
      ApiEndpoints.login,
      ApiEndpoints.verifyOtp,
      ApiEndpoints.resendOtp,
      ApiEndpoints.resetPassword,
      ApiEndpoints.forgotPassword,
    ];
    if (requests.any((request) => options.path.contains(request))) {
      handler.next(options);
      return;
    }

    final accessToken = await storage.get(AppConstants.accessTokenKey);
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
      final refreshToken = await storage.get(AppConstants.refreshTokenKey);

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

      final refreshResult = await _performTokenRefresh(refreshToken);

      if (refreshResult != null) {
        // Save new tokens
        await storage.saveAuthTokens(
          accessToken: refreshResult.accessToken,
          refreshToken: refreshResult.refreshToken,
        );

        // Retry original request with new token
        final response = await _retryRequest(
          err.requestOptions,
          refreshResult.accessToken,
        );
        handler.resolve(response);

        // Process queued requests
        await _processQueuedRequests(refreshResult.accessToken);
      } else {
        // Refresh failed, clear storage and navigate to login
        await _clearStorageAndNavigateToLogin();

        // Fail all queued requests
        _failQueuedRequests(err);

        handler.next(err);
      }
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
    return await refreshDio.fetch(options);
  }

  // Perform token refresh using direct HTTP call to avoid circular dependency
  Future<TokensModel?> _performTokenRefresh(String refreshToken) async {
    try {
      final response = await refreshDio.post(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200 && response.data != null) {
        return TokensModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      return null;
    }
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
    await storage.completeLogout();
    _router.go(Routes.login);
  }
}
