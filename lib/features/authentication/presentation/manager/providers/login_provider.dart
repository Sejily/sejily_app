import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/result/result.dart';
import 'package:sejily/core/repository/auth_repository.dart';
import '../../../../../core/newtorking/api_error.dart';
import 'auth_providers.dart';

class LoginState {
  final bool isLoading;
  final Result<Map<String, dynamic>>? result;

  LoginState({this.isLoading = false, this.result});

  LoginState copyWith({bool? isLoading, Result<Map<String, dynamic>>? result}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      result: result ?? this.result,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  final AuthRepository repo;
  LoginNotifier(this.repo) : super(LoginState());

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      state = state.copyWith(
        result: Result(
          error: ApiError(message: "من فضلك أدخل البريد وكلمة المرور"),
        ),
      );
      return;
    }

    state = state.copyWith(isLoading: true);

    final result = await repo.login(email, password);

    state = state.copyWith(isLoading: false, result: result);
  }
}

final loginNotifierProvider = StateNotifierProvider<LoginNotifier, LoginState>((
  ref,
) {
  final repo = ref.read(authRepositoryProvider);
  return LoginNotifier(repo);
});
