import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/newtorking/api_error_model.dart';
import 'package:sejily/core/newtorking/api_result.dart';
import 'package:sejily/features/authentication/data/repository/auth_repository.dart';

class ResetPasswordState {
  final bool isLoading;
  final ApiResult<void>? result;

  ResetPasswordState({this.isLoading = false, this.result});

  ResetPasswordState copyWith({bool? isLoading, ApiResult<void>? result}) {
    return ResetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      result: result ?? this.result,
    );
  }
}

class ResetPasswordNotifier extends StateNotifier<ResetPasswordState> {
  final AuthRepository repo;
  ResetPasswordNotifier(this.repo) : super(ResetPasswordState());

  Future<void> resetPassword(
    String email,
    String otp,
    String newPassword,
    String confirmPassword,
  ) async {
    if (newPassword != confirmPassword) {
      state = state.copyWith(
        result: ApiFailure(
          ApiErrorModel(message: "كلمتا المرور غير متطابقتين"),
        ),
      );
      return;
    }

    state = state.copyWith(isLoading: true, result: null);

    final result = await repo.resetPassword(email, otp, newPassword);

    state = state.copyWith(isLoading: false, result: result);
  }
}

final resetPasswordNotifierProvider =
    StateNotifierProvider<ResetPasswordNotifier, ResetPasswordState>((ref) {
      final repo = ref.read(authRepositoryProvider);
      return ResetPasswordNotifier(repo);
    });
