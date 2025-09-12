import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../authentication/data/repository/auth_repository.dart';
import '../../../data/models/user_model.dart';
import '../providers/medical_info_provider.dart';

class EditProfileState {
  final bool isLoading;
  final bool? success;

  EditProfileState({this.isLoading = false, this.success});

  EditProfileState copyWith({bool? isLoading, bool? success}) {
    return EditProfileState(
      isLoading: isLoading ?? this.isLoading,
      success: success,
    );
  }
}

class EditProfileNotifier extends StateNotifier<EditProfileState> {
  final AuthRepository repo;
  final Ref ref;

  EditProfileNotifier(this.repo, this.ref) : super(EditProfileState());

  Future<void> updateProfile(UserModel user) async {
    state = state.copyWith(isLoading: true);
    try {
      final medInfo = ref.read(medicalInfoProvider);
      final updatedUser = user.copyWith(
        bloodType: medInfo.bloodType ?? user.bloodType,
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
      );

      final success = await repo.updateProfile(updatedUser);
      state = state.copyWith(isLoading: false, success: success);
    } catch (_) {
      state = state.copyWith(isLoading: false, success: false);
    }
  }
}

final editProfileNotifierProvider =
    StateNotifierProvider<EditProfileNotifier, EditProfileState>((ref) {
      final repo = ref.watch(authRepositoryProvider);
      return EditProfileNotifier(repo, ref);
    });
