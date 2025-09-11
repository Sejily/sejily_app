import 'package:dio/dio.dart';
import 'package:sejily/core/newtorking/api_error_model.dart';
import 'package:sejily/core/utils/app_strings.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(message: AppStrings.connectionTimeoutError);
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(message: AppStrings.sendTimeoutError);
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(message: AppStrings.receiveTimeoutError);
        case DioExceptionType.badCertificate:
          return ApiErrorModel(message: AppStrings.badCertificateError);
        case DioExceptionType.badResponse:
          return _handleError(error.response?.statusCode, error.response?.data);
        case DioExceptionType.cancel:
          return ApiErrorModel(message: AppStrings.cancelledRequestError);
        case DioExceptionType.connectionError:
          return ApiErrorModel(message: AppStrings.connectionErrorMsg);
        case DioExceptionType.unknown:
          return ApiErrorModel(message: AppStrings.unexpectedError);
      }
    } else {
      return ApiErrorModel(
        errorMessages: [AppStrings.unexpectedError],
        message: AppStrings.unexpectedError,
      );
    }
  }
}

ApiErrorModel _handleError(int? statusCode, dynamic data) {
  String userMessage = _getStatusCodeMessage(statusCode);

  return ApiErrorModel(
    errorMessages: [userMessage],
    message: userMessage,
    statusCode: statusCode,
  );
}

String _getStatusCodeMessage(int? statusCode) {
  switch (statusCode) {
    case 400:
      return AppStrings.badRequestError;
    case 401:
      return AppStrings.unauthorizedError;
    case 403:
      return AppStrings.forbiddenError;
    case 404:
      return AppStrings.notFoundError;
    case 409:
      return AppStrings.conflictError;
    case 422:
      return AppStrings.badRequestError; // Validation errors
    case 500:
      return AppStrings.internalServerError;
    case 502:
    case 503:
    case 504:
      return AppStrings.serviceUnavailableError;
    default:
      return AppStrings.unexpectedError;
  }
}
