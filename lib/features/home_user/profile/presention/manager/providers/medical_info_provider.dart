import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/services/secure_storage_service.dart';

class MedicalInfoState {
  final String? medicalState;
  final String? sensitive;
  final String? height;
  final String? weight;
  final String? bloodType;

  MedicalInfoState({
    this.medicalState,
    this.sensitive,
    this.height,
    this.weight,
    this.bloodType,
  });

  MedicalInfoState copyWith({
    String? medicalState,
    String? sensitive,
    String? height,
    String? weight,
    String? bloodType,
  }) {
    return MedicalInfoState(
      medicalState: medicalState ?? this.medicalState,
      sensitive: sensitive ?? this.sensitive,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bloodType: bloodType ?? this.bloodType,
    );
  }
}

class MedicalInfoNotifier extends StateNotifier<MedicalInfoState> {
  MedicalInfoNotifier() : super(MedicalInfoState()) {
    _loadFromStorage();
  }

  final _storage = StorageService.instance;

  void _loadFromStorage() {
    final medicalState = _storage.get<String>('medicalState');
    final sensitive = _storage.get<String>('sensitive');
    final height = _storage.get<String>('height');
    final weight = _storage.get<String>('weight');
    final bloodType = _storage.get<String>('bloodType');

    state = state.copyWith(
      medicalState: medicalState,
      sensitive: sensitive,
      height: height,
      weight: weight,
      bloodType: bloodType,
    );
  }

  void setMedicalState(String value) {
    state = state.copyWith(medicalState: value);
    _storage.save('medicalState', value);
  }

  void setSensitive(String value) {
    state = state.copyWith(sensitive: value);
    _storage.save('sensitive', value);
  }

  void setHeight(String value) {
    state = state.copyWith(height: value);
    _storage.save('height', value);
  }

  void setWeight(String value) {
    state = state.copyWith(weight: value);
    _storage.save('weight', value);
  }

  void setBloodType(String? value) {
    state = state.copyWith(bloodType: value);
    if (value != null) _storage.save('bloodType', value);
  }
}

final medicalInfoProvider =
    StateNotifierProvider<MedicalInfoNotifier, MedicalInfoState>(
      (ref) => MedicalInfoNotifier(),
    );
