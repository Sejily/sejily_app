import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static Dio getDio() {
    final baseUrl = dotenv.env['BASE_URL'] ?? '';
    Duration defaultTimeout = const Duration(seconds: 15);
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: defaultTimeout,
        receiveTimeout: defaultTimeout,
        headers: {"Content-Type": "application/json"},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: "accessToken");
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
        onError: (err, handler) async {
          return handler.next(err);
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          error: true,
          compact: true,
        ),
      );
    }

    return dio;
  }
}
