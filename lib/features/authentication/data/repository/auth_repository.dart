import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/features/authentication/data/models/tokens_model.dart';
import 'package:sejily/core/newtorking/api_error_handler.dart';
import 'package:sejily/core/newtorking/api_result.dart';
import 'package:sejily/core/services/api_service.dart';
import 'package:sejily/features/authentication/data/models/full_doctor_registration_request.dart';
import 'package:sejily/features/authentication/data/models/full_patient_registration_request.dart';
import 'package:sejily/features/authentication/data/models/register_request.dart';
import 'package:sejily/features/authentication/data/models/resend_otp_request.dart';
import 'package:sejily/features/authentication/data/models/verify_otp_request.dart';
import 'package:sejily/features/authentication/data/models/verify_otp_response.dart';

class AuthRepository {
  final ApiService apiService;

  AuthRepository({required this.apiService});

  Future<ApiResult<void>> register({
    required RegisterRequest registerRequest,
  }) async {
    try {
      final response = await apiService.register(
        registerRequest: registerRequest,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<VerifyOtpResponse>> verifyOtp({
    required VerifyOtpRequest verifyOtpRequest,
  }) async {
    try {
      final response = await apiService.verifyOtp(
        verifyOtpRequest: verifyOtpRequest,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<void>> resendOtp({required String email}) async {
    try {
      final response = await apiService.resendOtp(
        resendOtpRequest: ResendOtpRequest(email: email),
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<void>> completeDoctorRegistration({
    required FullDoctorRegistrationRequest request,
  }) async {
    try {
      final response = await apiService.completeDoctorRegistration(
        nationality: request.nationality ?? '',
        nationalId: request.nationalId ?? '',
        phoneNumber: request.phoneNumber ?? '',
        dateOfBirth: request.dateOfBirth ?? '',
        gender: request.gender ?? '',
        address: request.address ?? '',
        city: request.city ?? '',
        specialization: request.specialization ?? '',
        hospitalAffiliation: request.hospitalAffiliation ?? '',
        licenseNumber: request.licenseNumber ?? '',
        profilePicture: request.profilePicture,
        idPicture: request.idPicture,
        healthCareCard: request.healthCareCard,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<void>> completePatientRegistration({
    required FullPatientRegistrationRequest request,
  }) async {
    try {
      final response = await apiService.completePatientRegistration(
        nationality: request.nationality ?? '',
        nationalId: request.nationalId ?? '',
        phoneNumber: request.phoneNumber ?? '',
        dateOfBirth: request.dateOfBirth ?? '1990-01-01',
        gender: request.gender ?? '',
        address: request.address ?? '',
        emergencyContactName: request.emergencyContactName ?? '',
        emergencyContactPhone: request.emergencyContactPhone ?? '',
        emergencyContactRelation: request.emergencyContactRelation ?? '',
        profilePicture: request.profilePicture,
        idPicture: request.idPicture,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<TokensModel>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final response = await apiService.refreshToken(
        refreshToken: refreshToken,
      );

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthRepository(apiService: apiService);
});
