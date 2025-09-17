import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/features/home_user/profile/presention/manager/providers/user_provider.dart';
import '../../../../../authentication/data/repository/auth_repository.dart';
import '../../../data/models/user_model.dart';
import '../providers/medical_info_provider.dart';

class EditProfileState {
  final bool isLoading;
  final bool? success;
  final String? errorMessage;

  EditProfileState({this.isLoading = false, this.success, this.errorMessage});

  EditProfileState copyWith({
    bool? isLoading,
    bool? success,
    String? errorMessage,
  }) {
    return EditProfileState(
      isLoading: isLoading ?? this.isLoading,
      success: success,
      errorMessage: errorMessage,
    );
  }
}

class EditProfileNotifier extends StateNotifier<EditProfileState> {
  final AuthRepository repo;
  final Ref ref;

  EditProfileNotifier(this.repo, this.ref) : super(EditProfileState());

  Future<void> updateProfile(UserModel user) async {
    state = state.copyWith(isLoading: true, success: null, errorMessage: null);

    try {
      final medInfo = ref.read(medicalInfoProvider);

      final updatedUser = user.copyWith(
        bloodType: medInfo.bloodType,
        height: medInfo.height != null
            ? double.tryParse(medInfo.height!)
            : user.height,
        weight: medInfo.weight != null
            ? double.tryParse(medInfo.weight!)
            : user.weight,
        medicalConditions: medInfo.medicalState != null
            ? [medInfo.medicalState!]
            : user.medicalConditions,
        allergies: medInfo.sensitive != null
            ? [medInfo.sensitive!]
            : user.allergies,
        city: user.city,
      );

      final result = await repo.updateProfile(updatedUser);

      result.when(
        onSuccess: (resp) {
          ref.invalidate(userProfileProvider);

          state = state.copyWith(isLoading: false, success: true);
        },
        onFailure: (error) {
          state = state.copyWith(
            isLoading: false,
            success: false,
            errorMessage: error.message,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        success: false,
        errorMessage: e.toString(),
      );
    }
  }
}

final editProfileNotifierProvider =
    StateNotifierProvider<EditProfileNotifier, EditProfileState>((ref) {
      final repo = ref.watch(authRepositoryProvider);
      return EditProfileNotifier(repo, ref);
    });
