import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/newtorking/api_result.dart';
import '../../../data/models/user_model.dart';
import '../../../../../authentication/data/repository/auth_repository.dart';

class EditProfileState {
  final bool isLoading;
  final ApiResult<UserModel>? result;

  EditProfileState({this.isLoading = false, this.result});

  EditProfileState copyWith({bool? isLoading, ApiResult<UserModel>? result}) {
    return EditProfileState(
      isLoading: isLoading ?? this.isLoading,
      result: result ?? this.result,
    );
  }
}

class EditProfileNotifier extends StateNotifier<EditProfileState> {
  final AuthRepository repo;

  EditProfileNotifier(this.repo) : super(EditProfileState());

  Future<void> updateProfile(UserModel user) async {
    state = state.copyWith(isLoading: true);

    final result = await repo.updateProfile(user);

    state = state.copyWith(isLoading: false, result: result);
  }
}

final editProfileNotifierProvider =
    StateNotifierProvider<EditProfileNotifier, EditProfileState>((ref) {
      final repo = ref.watch(authRepositoryProvider);
      return EditProfileNotifier(repo);
    });
