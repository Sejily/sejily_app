import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sejily/core/result/result.dart';
import '../../../../../core/repository/auth_repository.dart';
import 'auth_providers.dart';

class ResetPasswordState {
  final bool isLoading;
  final bool success;
  final String? error;

  ResetPasswordState({
    this.isLoading = false,
    this.success = false,
    this.error,
  });

  ResetPasswordState copyWith({bool? isLoading, bool? success, String? error}) {
    return ResetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      error: error,
    );
  }
}

class ResetPasswordNotifier extends StateNotifier<ResetPasswordState> {
  final AuthRepository _repo;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  ResetPasswordNotifier(this._repo) : super(ResetPasswordState());

  Future<void> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (newPassword != confirmPassword) {
      state = state.copyWith(error: "كلمتا المرور غير متطابقتين");
      return;
    }

    final email = await _storage.read(key: "email") ?? "";
    final otp = await _storage.read(key: "otp") ?? "";

    if (email.isEmpty || otp.isEmpty) {
      state = state.copyWith(error: "حدث خطأ. يرجى إعادة المحاولة.");
      return;
    }

    state = state.copyWith(isLoading: true, error: null, success: false);

    try {
      final Result<Map<String, dynamic>> result = await _repo.resetPassword(
        email,
        otp,
        newPassword,
      );

      if (result.error != null) {
        state = state.copyWith(isLoading: false, error: result.error!.message);
      } else {
        state = state.copyWith(isLoading: false, success: true);
        await _storage.delete(key: "otp");
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: "حدث خطأ غير متوقع");
    }
  }
}

final resetPasswordProvider =
    StateNotifierProvider<ResetPasswordNotifier, ResetPasswordState>((ref) {
      final repo = ref.read(authRepositoryProvider);
      return ResetPasswordNotifier(repo);
    });
