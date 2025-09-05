import 'package:dio/dio.dart';
import 'package:sejily/core/constants/api_endpoints.dart';
import 'package:sejily/core/newtorking/dio_factory.dart';

class AuthApi {
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.post(
        ApiEndpoints.login,
        data: {"email": email, "password": password},
      );
      return response.data;
    } on DioException catch (e) {
      return e.response?.data ?? {"success": false, "message": "Server error"};
    } catch (e) {
      return {"success": false, "message": "Unexpected error"};
    }
  }

  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.post(
        ApiEndpoints.forgotPassword,
        data: {"email": email},
      );
      return response.data;
    } on DioException catch (e) {
      return e.response?.data ?? {"success": false, "message": "Server error"};
    } catch (e) {
      return {"success": false, "message": "Unexpected error"};
    }
  }

  static Future<Map<String, dynamic>> resetPassword(
    String email,
    String otp,
    String newPassword,
  ) async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.post(
        ApiEndpoints.resetPassword,
        data: {"email": email, "otp": otp, "newPassword": newPassword},
      );
      return response.data;
    } on DioException catch (e) {
      return e.response?.data ?? {"success": false, "message": "Server error"};
    } catch (e) {
      return {"success": false, "message": "Unexpected error"};
    }
  }

  static Future<Map<String, dynamic>> verifyOtp(
    String email,
    String otp,
  ) async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.post(
        ApiEndpoints.verifyOtp,
        data: {"email": email, "otp": otp},
      );
      return response.data;
    } on DioException catch (e) {
      return e.response?.data ?? {"success": false, "message": "Server error"};
    } catch (e) {
      return {"success": false, "message": "Unexpected error"};
    }
  }

  static Future<Map<String, dynamic>> resendOtp(String email) async {
    try {
      final dio = DioFactory.getDio();
      final response = await dio.post(
        ApiEndpoints.resendOtp,
        data: {"email": email},
      );
      return response.data;
    } on DioException catch (e) {
      return e.response?.data ?? {"success": false, "message": "Server error"};
    } catch (e) {
      return {"success": false, "message": "Unexpected error"};
    }
  }
}
