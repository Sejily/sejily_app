import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/result/result.dart';
import 'package:sejily/core/repository/auth_repository.dart';
import '../../../../../core/newtorking/api_error.dart';
import 'auth_providers.dart';

class ResetPasswordState {
  final bool isLoading;
  final Result<Map<String, dynamic>>? result;

  ResetPasswordState({this.isLoading = false, this.result});

  ResetPasswordState copyWith({
    bool? isLoading,
    Result<Map<String, dynamic>>? result,
  }) {
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
        result: Result(error: ApiError(message: "كلمتا المرور غير متطابقتين")),
      );
      return;
    }

    state = state.copyWith(isLoading: true);

    final result = await repo.resetPassword(email, otp, newPassword);

    state = state.copyWith(isLoading: false, result: result);
  }
}

final resetPasswordNotifierProvider =
    StateNotifierProvider<ResetPasswordNotifier, ResetPasswordState>((ref) {
      final repo = ref.read(authRepositoryProvider);
      return ResetPasswordNotifier(repo);
    });
