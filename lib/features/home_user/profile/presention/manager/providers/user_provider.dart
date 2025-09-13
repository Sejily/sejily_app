import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../authentication/data/repository/auth_repository.dart';
import '../../../data/models/user_model.dart';
import 'package:sejily/core/newtorking/api_result.dart';

final userProfileProvider =
    StateNotifierProvider<
      UserProfileNotifier,
      AsyncValue<ApiResult<UserModel>>
    >((ref) {
      final repo = ref.watch(authRepositoryProvider);
      return UserProfileNotifier(repo);
    });

class UserProfileNotifier
    extends StateNotifier<AsyncValue<ApiResult<UserModel>>> {
  final AuthRepository repo;

  UserProfileNotifier(this.repo) : super(const AsyncLoading()) {
    getProfile();
  }

  Future<void> getProfile() async {
    state = const AsyncLoading();
    try {
      final result = await repo.getProfile();
      state = AsyncData(result);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateProfile(UserModel user) async {
    try {
      final result = await repo.updateProfile(user);
      if (result is ApiSuccess) {
        await getProfile();
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
