import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/result/result.dart';
import 'package:sejily/core/repository/auth_repository.dart';
import '../../../../../core/newtorking/api_error.dart';
import 'auth_providers.dart';

class OtpState {
  final bool isLoading;
  final Result<Map<String, dynamic>>? result;

  OtpState({this.isLoading = false, this.result});

  OtpState copyWith({bool? isLoading, Result<Map<String, dynamic>>? result}) {
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
        result: Result(
          error: ApiError(message: "من فضلك أدخل رمز التحقق بالكامل"),
        ),
      );
      return;
    }

    state = state.copyWith(isLoading: true);

    final result = await repo.verifyOtp(email, otp);

    state = state.copyWith(isLoading: false, result: result);
  }
}

final otpNotifierProvider = StateNotifierProvider<OtpNotifier, OtpState>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return OtpNotifier(repo);
});
