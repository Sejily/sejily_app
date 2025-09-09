import 'package:dio/dio.dart';
import 'api_error.dart';

class ErrorHandler {
  static ApiError handle(dynamic error) {
    if (error is DioException) {
      final resp = error.response;
      if (resp != null && resp.data is Map && resp.data['message'] != null) {
        return ApiError(
          message: resp.data['message'].toString(),
          statusCode: resp.statusCode,
        );
      } else if (resp != null) {
        return ApiError(message: "Server error", statusCode: resp.statusCode);
      } else {
        return ApiError(message: "خطأ في الاتصال بالسيرفر");
      }
    } else {
      return ApiError(message: "حدث خطأ غير متوقع");
    }
  }
}
