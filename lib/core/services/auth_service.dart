import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sejily/core/constants/api_endpoints.dart';
import 'package:sejily/features/authentication/data/models/tokens_model.dart';
import 'package:sejily/core/newtorking/dio_factory.dart';
import 'package:sejily/features/authentication/data/models/register_request.dart';
import 'package:sejily/features/authentication/data/models/verify_otp_request.dart';
import 'package:sejily/features/authentication/data/models/verify_otp_response.dart';
import 'package:sejily/features/authentication/data/models/resend_otp_request.dart';
import 'package:sejily/features/authentication/data/models/login_response.dart';

import '../../features/home_user/profile/data/models/user_model.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio) = _AuthService;

  @POST(ApiEndpoints.register)
  Future<void> register({@Body() required RegisterRequest registerRequest});

  @POST(ApiEndpoints.verifyOtp)
  Future<VerifyOtpResponse> verifyOtp({
    @Body() required VerifyOtpRequest verifyOtpRequest,
  });

  @POST(ApiEndpoints.resendOtp)
  Future<void> resendOtp({@Body() required ResendOtpRequest resendOtpRequest});

  @POST(ApiEndpoints.completeDoctorRegistration)
  @MultiPart()
  Future<void> completeDoctorRegistration({
    @Part() required String nationality,
    @Part() required String nationalId,
    @Part() required String phoneNumber,
    @Part() required String dateOfBirth,
    @Part() required String gender,
    @Part() required String address,
    @Part() required String city,
    @Part() required String specialization,
    @Part() required String hospitalAffiliation,
    @Part() required String licenseNumber,
    @Part() File? profilePicture,
    @Part() File? idPicture,
    @Part() File? healthCareCard,
  });

  @POST(ApiEndpoints.completePatientRegistration)
  @MultiPart()
  Future<void> completePatientRegistration({
    @Part() required String nationality,
    @Part() required String nationalId,
    @Part() required String phoneNumber,
    @Part() required String dateOfBirth,
    @Part() required String gender,
    @Part() required String address,
    @Part() required String emergencyContactName,
    @Part() required String emergencyContactPhone,
    @Part() required String emergencyContactRelation,
    @Part() File? profilePicture,
    @Part() File? idPicture,
  });

  @POST(ApiEndpoints.refreshToken)
  Future<TokensModel> refreshToken(@Body() Map<String, dynamic> body);

  @POST(ApiEndpoints.login)
  Future<LoginResponse> login(@Body() Map<String, dynamic> body);

  @POST(ApiEndpoints.forgotPassword)
  Future<void> forgotPassword(@Body() Map<String, dynamic> body);

  @POST(ApiEndpoints.resetPassword)
  Future<void> resetPassword(@Body() Map<String, dynamic> body);

  @GET(ApiEndpoints.profile)
  Future<UserModel> getProfile();

  @PUT(ApiEndpoints.updateProfile)
  Future<UserModel> updateProfile(@Body() Map<String, dynamic> body);
}

final authServiceProvider = Provider<AuthService>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthService(dio);
});
