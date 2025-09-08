import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST("/auth/login")
  Future<HttpResponse<Map<String, dynamic>>> login(
    @Body() Map<String, dynamic> body,
  );

  @POST("/auth/forgot-password")
  Future<HttpResponse<Map<String, dynamic>>> forgotPassword(
    @Body() Map<String, dynamic> body,
  );

  @POST("/auth/verify-otp")
  Future<HttpResponse<Map<String, dynamic>>> verifyOtp(
    @Body() Map<String, dynamic> body,
  );

  @POST("/auth/resend-otp")
  Future<HttpResponse<Map<String, dynamic>>> resendOtp(
    @Body() Map<String, dynamic> body,
  );

  @POST("/auth/reset-password")
  Future<HttpResponse<Map<String, dynamic>>> resetPassword(
    @Body() Map<String, dynamic> body,
  );
}
