import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sejily/core/result/result.dart';
import '../../features/authentication/data/auth_api.dart';
import '../newtorking/api_error.dart';
import '../newtorking/error_handler.dart';

class AuthRepository {
  final AuthApi api;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthRepository(this.api);

  Future<Result<Map<String, dynamic>>> login(
    String email,
    String password,
  ) async {
    try {
      final resp = await api.login({"email": email, "password": password});
      final data = resp.data;
      if (resp.response.statusCode == 200 && data["success"] == true) {
        final accessToken = data["data"]["accessToken"];
        final refreshToken = data["data"]["refreshToken"];
        await _storage.write(key: "accessToken", value: accessToken);
        await _storage.write(key: "refreshToken", value: refreshToken);
        return Result(data: data);
      } else {
        return Result(
          error: ApiError(message: data["message"] ?? "فشل تسجيل الدخول"),
        );
      }
    } catch (e) {
      return Result(error: ErrorHandler.handle(e));
    }
  }

  Future<Result<Map<String, dynamic>>> forgotPassword(String email) async {
    try {
      final resp = await api.forgotPassword({"email": email});
      return Result(data: resp.data);
    } catch (e) {
      return Result(error: ErrorHandler.handle(e));
    }
  }

  Future<Result<Map<String, dynamic>>> verifyOtp(
    String email,
    String otp,
  ) async {
    try {
      final resp = await api.verifyOtp({"email": email, "otp": otp});
      return Result(data: resp.data);
    } catch (e) {
      return Result(error: ErrorHandler.handle(e));
    }
  }

  Future<Result<Map<String, dynamic>>> resetPassword(
    String email,
    String otp,
    String newPassword,
  ) async {
    try {
      final resp = await api.resetPassword({
        "email": email,
        "otp": otp,
        "newPassword": newPassword,
      });
      return Result(data: resp.data);
    } catch (e) {
      return Result(error: ErrorHandler.handle(e));
    }
  }

  Future<Result<Map<String, dynamic>>> resendOtp(String email) async {
    try {
      final resp = await api.resendOtp({"email": email});
      return Result(data: resp.data);
    } catch (e) {
      return Result(error: ErrorHandler.handle(e));
    }
  }
}
