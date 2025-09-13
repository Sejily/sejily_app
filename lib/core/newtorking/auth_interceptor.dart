import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/helpers/storage_extension.dart';
import 'package:sejily/core/routes/app_router.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/services/token_service.dart';

final authInterceptorProvider = Provider.family<AuthInterceptor, Dio>((
  ref,
  dio,
) {
  final tokenService = ref.watch(tokenServiceProvider(dio));
  final router = ref.watch(routerProvider);

  return AuthInterceptor(tokenService, dio, router);
});

final class AuthInterceptor extends Interceptor {
  final TokenService _tokenService;
  final Dio _dio;
  final GoRouter router;

  AuthInterceptor(this._tokenService, this._dio, this.router);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await storage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    List<String> authRoutes = [
      Routes.login,
      Routes.register,
      Routes.forgetPassword,
      Routes.resetPassword,
    ];

    if (!authRoutes.contains(err.requestOptions.path) &&
        (err.response?.statusCode == 401 || err.response?.statusCode == 403)) {
      final refreshToken = await _tokenService.getRefreshToken();

      try {
        final result = await _tokenService.refreshToken(refreshToken);

        final accessToken = result.accessToken;
        final newRefreshToken = result.refreshToken;

        await _tokenService.saveToken(accessToken, newRefreshToken);

        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer $accessToken';

        final response = await _dio.fetch(options);
        return handler.resolve(response);
      } on DioException catch (_) {
        await _tokenService.clearToken();
        router.go(Routes.login);
        return handler.next(err);
      }
    }

    return handler.next(err);
  }
}
