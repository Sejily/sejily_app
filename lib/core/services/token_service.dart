import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/constants/api_endpoints.dart';
import 'package:sejily/core/helpers/storage_extension.dart';
import 'package:sejily/features/authentication/data/models/tokens_model.dart';

final tokenServiceProvider = Provider.family<TokenService, Dio>((ref, dio) {
  return TokenService(dio);
});

final class TokenService {
  final Dio _dio;

  TokenService(this._dio);

  Future<void> clearToken() {
    return storage.clearAllSecure();
  }

  Future<String?> getAccessToken() => storage.getAccessToken();

  Future<String?> getRefreshToken() => storage.getRefreshToken();

  Future<TokensModel> refreshToken(String? refreshToken) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiEndpoints.refreshToken,
      data: {"refreshToken": refreshToken},
    );

    if (response.statusCode == 200) {
      return TokensModel.fromJson(response.data ?? {});
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
      );
    }
  }

  Future<void> saveToken(String accessToken, String refreshToken) {
    return storage.saveAuthTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
