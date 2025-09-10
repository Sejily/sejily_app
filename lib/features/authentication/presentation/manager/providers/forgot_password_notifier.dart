import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/newtorking/api_error_model.dart';
import 'package:sejily/core/newtorking/api_result.dart';
import 'package:sejily/features/authentication/data/repository/auth_repository.dart';

class ForgotPasswordState {
  final bool isLoading;
  final ApiResult<void>? result;

  ForgotPasswordState({this.isLoading = false, this.result});

  ForgotPasswordState copyWith({bool? isLoading, ApiResult<void>? result}) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      result: result ?? this.result,
    );
  }
}

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  final AuthRepository repo;
  ForgotPasswordNotifier(this.repo) : super(ForgotPasswordState());

  Future<void> sendOtp(String email) async {
    if (email.isEmpty) {
      state = state.copyWith(
        result: ApiResult.failure(
          ApiErrorModel(message: "من فضلك أدخل البريد الإلكتروني"),
        ),
      );
      return;
    }

    state = state.copyWith(isLoading: true, result: null);

    final result = await repo.forgotPassword(email);

    state = state.copyWith(isLoading: false, result: result);
  }
}

final forgotPasswordNotifierProvider =
    StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>((ref) {
      final repo = ref.read(authRepositoryProvider);
      return ForgotPasswordNotifier(repo);
    });
