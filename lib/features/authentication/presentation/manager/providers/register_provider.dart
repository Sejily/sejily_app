import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/constants/app_constants.dart';
import 'package:sejily/core/enums/user_role.dart';
import 'package:sejily/core/helpers/storage_extension.dart';
import 'package:sejily/core/newtorking/api_error_handler.dart';
import 'package:sejily/features/authentication/data/models/full_doctor_registration_request.dart';
import 'package:sejily/features/authentication/data/models/full_patient_registration_request.dart';
import 'package:sejily/features/authentication/data/models/register_request.dart';
import 'package:sejily/features/authentication/data/models/verify_otp_request.dart';
import 'package:sejily/features/authentication/data/repository/auth_repository.dart';
import 'package:sejily/features/authentication/presentation/manager/auth_state.dart';
import 'package:sejily/core/newtorking/api_error_model.dart';

class RegisterNotifier extends StateNotifier<AuthState> {
  RegisterNotifier(this._authRepository, this._ref)
    : super(const AuthState.initial());

  final AuthRepository _authRepository;
  final Ref _ref;

  //* Register
  Future<void> register({required RegisterRequest registerRequest}) async {
    state = const AuthState.loading();

    try {
      final result = await _authRepository.register(
        registerRequest: registerRequest,
      );
      result.when(
        onSuccess: (data) => state = const AuthState.success(),
        onFailure: (error) => state = AuthState.failure(error),
      );
    } catch (e) {
      state = AuthState.failure(ApiErrorHandler.handle(e));
    }
  }

  //* Verify OTP
  //* Verify OTP
  Future<void> verifyOtp({required String email, required String otp}) async {
    state = const AuthState.loading();

    try {
      final result = await _authRepository.verifyOtp(
        verifyOtpRequest: VerifyOtpRequest(email: email, otp: otp),
      );

      await result.when(
        onSuccess: (verifyOtpResponse) async {
          if (verifyOtpResponse.isSuccess) {
            // Save tokens using storage extension
            await storage.saveAuthTokens(
              accessToken: verifyOtpResponse.accessToken,
              refreshToken: verifyOtpResponse.refreshToken,
            );
            state = const AuthState.success();
          } else {
            state = AuthState.failure(
              ApiErrorModel(message: 'Verification failed'),
            );
          }
        },
        onFailure: (error) async {
          state = AuthState.failure(error);
        },
      );
    } catch (e) {
      state = AuthState.failure(ApiErrorHandler.handle(e));
    }
  }

  //* Resend OTP
  Future<void> resendOtp({required String email}) async {
    state = const AuthState.loading();

    try {
      final result = await _authRepository.resendOtp(email: email);
      result.when(
        onSuccess: (data) => state = const AuthState.initial(),
        onFailure: (error) => state = AuthState.failure(error),
      );
    } catch (e) {
      state = AuthState.failure(ApiErrorModel(message: e.toString()));
    }
  }

  //* Complete Doctor Registration Data
  Future<void> completeDoctorRegistrationData({
    required FullDoctorRegistrationRequest request,
  }) async {
    state = const AuthState.loading();
    try {
      final result = await _authRepository.completeDoctorRegistration(
        request: request,
      );
      await result.when(
        onSuccess: (_) async => state = const AuthState.success(),
        onFailure: (error) async => state = AuthState.failure(error),
      );
    } catch (e) {
      state = AuthState.failure(ApiErrorHandler.handle(e));
    }
  }

  //* Complete Patient Registration Data
  Future<void> completePatientRegistrationData({
    required FullPatientRegistrationRequest request,
  }) async {
    state = const AuthState.loading();
    try {
      final result = await _authRepository.completePatientRegistration(
        request: request,
      );
      await result.when(
        onSuccess: (_) async => state = const AuthState.success(),
        onFailure: (error) async => state = AuthState.failure(error),
      );
    } catch (e) {
      state = AuthState.failure(ApiErrorHandler.handle(e));
    }
  }

  //* Update user registration data based on user role
  Future<void> updateUserData({
    // Personal information (common for both doctor and patient)
    String? address,
    String? dateOfBirth,
    String? phoneNumber,
    String? gender,
    String? nationality,
    String? nationalId,
    dynamic profilePicture, // File?
    dynamic idPicture, // File?
    // Patient-specific data
    String? emergencyContactName,
    String? emergencyContactPhone,
    String? emergencyContactRelation,

    // Doctor-specific data
    String? city,
    String? specialization,
    String? licenseNumber,
    String? hospitalAffiliation,
    dynamic healthCareCard, // File?
  }) async {
    final isDoctor =
        storage.get(AppConstants.userRoleKey) ==
        UserRole.healthcareProvider.value;

    if (isDoctor) {
      // Update doctor registration data
      _ref
          .read(doctorRegistrationProvider.notifier)
          .update(
            (state) => state.copyWith(
              address: address ?? state.address,
              dateOfBirth: dateOfBirth ?? state.dateOfBirth,
              phoneNumber: phoneNumber ?? state.phoneNumber,
              gender: gender ?? state.gender,
              nationality: nationality ?? state.nationality,
              nationalId: nationalId ?? state.nationalId,
              profilePicture: profilePicture ?? state.profilePicture,
              idPicture: idPicture ?? state.idPicture,
              city: city ?? state.city,
              specialization: specialization ?? state.specialization,
              licenseNumber: licenseNumber ?? state.licenseNumber,
              hospitalAffiliation:
                  hospitalAffiliation ?? state.hospitalAffiliation,
              healthCareCard: healthCareCard ?? state.healthCareCard,
            ),
          );
    } else {
      // Update patient registration data
      _ref
          .read(patientRegistrationProvider.notifier)
          .update(
            (state) => state.copyWith(
              address: address ?? state.address,
              dateOfBirth: dateOfBirth ?? state.dateOfBirth,
              phoneNumber: phoneNumber ?? state.phoneNumber,
              gender: gender ?? state.gender,
              nationality: nationality ?? state.nationality,
              nationalId: nationalId ?? state.nationalId,
              profilePicture: profilePicture ?? state.profilePicture,
              idPicture: idPicture ?? state.idPicture,
              emergencyContactName:
                  emergencyContactName ?? state.emergencyContactName,
              emergencyContactPhone:
                  emergencyContactPhone ?? state.emergencyContactPhone,
              emergencyContactRelation:
                  emergencyContactRelation ?? state.emergencyContactRelation,
            ),
          );
    }
  }
}

//* The auth providers
final registerNotifierProvider =
    StateNotifierProvider<RegisterNotifier, AuthState>((ref) {
      final authRepository = ref.watch(authRepositoryProvider);
      return RegisterNotifier(authRepository, ref);
    });

final patientRegistrationProvider =
    StateProvider<FullPatientRegistrationRequest>((ref) {
      return FullPatientRegistrationRequest();
    });

final doctorRegistrationProvider = StateProvider<FullDoctorRegistrationRequest>(
  (ref) {
    return FullDoctorRegistrationRequest();
  },
);
