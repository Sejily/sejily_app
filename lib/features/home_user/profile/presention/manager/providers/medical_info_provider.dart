import 'package:flutter_riverpod/flutter_riverpod.dart';

class MedicalInfoState {
  final String? bloodType;

  MedicalInfoState({this.bloodType});

  MedicalInfoState copyWith({String? bloodType}) {
    return MedicalInfoState(bloodType: bloodType ?? this.bloodType);
  }
}

class MedicalInfoNotifier extends StateNotifier<MedicalInfoState> {
  MedicalInfoNotifier() : super(MedicalInfoState());

  void setBloodType(String? bloodType) {
    state = state.copyWith(bloodType: bloodType);
  }
}

final medicalInfoProvider =
    StateNotifierProvider<MedicalInfoNotifier, MedicalInfoState>(
      (ref) => MedicalInfoNotifier(),
    );
