import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/newtorking/api_error_model.dart';
import 'package:sejily/core/newtorking/api_result.dart';
import 'package:sejily/features/authentication/data/repository/auth_repository.dart';
import 'package:sejily/features/authentication/data/models/login_response.dart';

class LoginState {
  final bool isLoading;
  final ApiResult<LoginResponse>? result;

  LoginState({this.isLoading = false, this.result});

  LoginState copyWith({bool? isLoading, ApiResult<LoginResponse>? result}) {
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
        result: ApiFailure(
          ApiErrorModel(message: "من فضلك أدخل البريد وكلمة المرور"),
        ),
      );
      return;
    }

    state = state.copyWith(isLoading: true, result: null);

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
