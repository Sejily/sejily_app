import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/newtorking/api_error_model.dart';
import 'package:sejily/core/newtorking/api_result.dart';
import 'package:sejily/features/authentication/data/models/verify_otp_request.dart';
import 'package:sejily/features/authentication/data/models/verify_otp_response.dart';
import 'package:sejily/features/authentication/data/repository/auth_repository.dart';

class OtpState {
  final bool isLoading;
  final ApiResult<VerifyOtpResponse>? result;

  OtpState({this.isLoading = false, this.result});

  OtpState copyWith({bool? isLoading, ApiResult<VerifyOtpResponse>? result}) {
    return OtpState(
      isLoading: isLoading ?? this.isLoading,
      result: result ?? this.result,
    );
  }
}

class OtpNotifier extends StateNotifier<OtpState> {
  final AuthRepository repo;
  OtpNotifier(this.repo) : super(OtpState());

  Future<void> verifyOtp(String email, String otp) async {
    if (otp.isEmpty || otp.length < 6) {
      state = state.copyWith(
        result: ApiFailure(
          ApiErrorModel(message: "من فضلك أدخل رمز التحقق بالكامل"),
        ),
      );
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      final result = await repo.verifyOtp(
        verifyOtpRequest: VerifyOtpRequest(email: email, otp: otp),
      );

      state = state.copyWith(isLoading: false, result: result);
    } catch (e) {
      // Handle any unexpected errors that might occur
      state = state.copyWith(
        isLoading: false,
        result: ApiFailure(
          ApiErrorModel(message: "حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى"),
        ),
      );
    }
  }
}

final otpNotifierProvider = StateNotifierProvider<OtpNotifier, OtpState>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return OtpNotifier(repo);
});
