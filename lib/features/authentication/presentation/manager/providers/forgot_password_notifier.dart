import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/result/result.dart';
import 'package:sejily/core/repository/auth_repository.dart';
import '../../../../../core/newtorking/api_error.dart';
import 'auth_providers.dart';

class ForgotPasswordState {
  final bool isLoading;
  final Result<Map<String, dynamic>>? result;

  ForgotPasswordState({this.isLoading = false, this.result});

  ForgotPasswordState copyWith({
    bool? isLoading,
    Result<Map<String, dynamic>>? result,
  }) {
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
        result: Result(
          error: ApiError(message: "من فضلك أدخل البريد الإلكتروني"),
        ),
      );
      return;
    }

    state = state.copyWith(isLoading: true);

    final result = await repo.forgotPassword(email);

    state = state.copyWith(isLoading: false, result: result);
  }
}

final forgotPasswordNotifierProvider =
    StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>((ref) {
      final repo = ref.read(authRepositoryProvider);
      return ForgotPasswordNotifier(repo);
    });
