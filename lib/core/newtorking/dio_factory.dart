import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static Dio getDio() {
    Duration defaultTimeout = const Duration(seconds: 8);
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['BASE_URL'] ?? '',
        connectTimeout: defaultTimeout,
        receiveTimeout: defaultTimeout,
        headers: {"Content-Type": "application/json"},
      ),
    );
    _addInterceptors(dio);
    return dio;
  }

  static void _addInterceptors(Dio dio) {
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: "accessToken");
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
      ),
      if (kDebugMode)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
    ]);
  }
}
