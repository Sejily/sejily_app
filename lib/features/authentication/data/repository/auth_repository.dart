import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/helpers/storage_extension.dart';
import 'package:sejily/features/authentication/data/models/tokens_model.dart';
import 'package:sejily/core/newtorking/api_error_handler.dart';
import 'package:sejily/core/newtorking/api_result.dart';
import 'package:sejily/core/newtorking/api_error_model.dart';
import 'package:sejily/core/services/auth_service.dart';
import 'package:sejily/features/authentication/data/models/full_doctor_registration_request.dart';
import 'package:sejily/features/authentication/data/models/full_patient_registration_request.dart';
import 'package:sejily/features/authentication/data/models/register_request.dart';
import 'package:sejily/features/authentication/data/models/resend_otp_request.dart';
import 'package:sejily/features/authentication/data/models/verify_otp_request.dart';
import 'package:sejily/features/authentication/data/models/verify_otp_response.dart';
import 'package:sejily/features/authentication/data/models/login_response.dart';

import '../../../home_user/profile/data/models/user_model.dart';
import 'auth_repository.dart' as authService;

class AuthRepository {
  final AuthService authService;

  AuthRepository({required this.authService});

  Future<ApiResult<void>> register({
    required RegisterRequest registerRequest,
  }) async {
    try {
      final response = await authService.register(
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
      final response = await authService.verifyOtp(
        verifyOtpRequest: verifyOtpRequest,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<void>> resendOtp({required String email}) async {
    try {
      final response = await authService.resendOtp(
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
      final response = await authService.completeDoctorRegistration(
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
      final response = await authService.completePatientRegistration(
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
      final response = await authService.refreshToken({
        'refreshToken': refreshToken,
      });

      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<LoginResponse>> login(String email, String password) async {
    try {
      final response = await authService.login({
        "email": email,
        "password": password,
      });

      if (response.isSuccess) {
        await storage.saveAuthTokens(
          refreshToken: response.refreshToken,
          accessToken: response.accessToken,
        );
        return ApiSuccess(response);
      } else {
        return ApiFailure(const ApiErrorModel(message: "فشل تسجيل الدخول"));
      }
    } catch (e) {
      return ApiFailure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<void>> forgotPassword(String email) async {
    try {
      await authService.forgotPassword({"email": email});
      return ApiSuccess(null);
    } catch (e) {
      return ApiFailure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<void>> resetPassword(
    String email,
    String otp,
    String newPassword,
  ) async {
    try {
      await authService.resetPassword({
        "email": email,
        "otp": otp,
        "newPassword": newPassword,
      });
      return ApiSuccess(null);
    } catch (e) {
      return ApiFailure(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResult<UserModel>> getProfile() async {
    try {
      final response = await authService.getProfile();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<bool> updateProfile(UserModel user) async {
    try {
      await authService.updateProfile(user.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthRepository(authService: authService);
});
