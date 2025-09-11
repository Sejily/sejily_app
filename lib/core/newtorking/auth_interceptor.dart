import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    final accessToken = await _tokenService.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    List<String> routes = [
      Routes.login,
      Routes.register,
      Routes.forgetPassword,
      Routes.resetPassword,
    ];

    if (!routes.contains(err.requestOptions.path) &&
        (err.response?.statusCode == 401 || err.response?.statusCode == 403)) {
      final token = await _tokenService.getRefreshToken();

      try {
        final result = await _tokenService.refreshToken(token);

        final accesToken = result.accessToken;
        final refreshToken = result.refreshToken;

        // save new access token and refresh token to secure storage
        await _tokenService.saveToken(accesToken, refreshToken);

        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer $accesToken';
        return handler.resolve(await _dio.fetch(options));
      } on DioException catch (_) {
        await _tokenService.clearToken();
        router.go(Routes.login);
        return handler.next(err);
      } finally {
        handler.next(err);
      }
    }
  }
}
