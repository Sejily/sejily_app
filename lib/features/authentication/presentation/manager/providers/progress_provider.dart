import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/routes/routes.dart';

final progressProvider = StateNotifierProvider<ProgressNotifier, int>((ref) {
  return ProgressNotifier();
});

class ProgressNotifier extends StateNotifier<int> {
  ProgressNotifier() : super(1);

  static const int totalSteps = 6;

  void nextStep() {
    if (state < totalSteps) {
      state = state + 1;
    }
  }

  void previousStep() {
    if (state > 1) {
      state = state - 1;
    }
  }

  void setStep(int step) {
    if (step >= 1 && step <= totalSteps) {
      state = step;
    }
  }

  void reset() {
    state = 1;
  }

  double get progressPercentage => state / totalSteps;

  // Route-to-step mapping for automatic step detection
  static const Map<String, int> _routeStepMap = {
    Routes.completeUserData: 1,
    Routes.uploadNationalId: 2,
    Routes.uploadPersonalPhoto: 3,
    Routes.uploadHospitalAffiliation: 4,
    Routes.uploadMedicalLicense: 5,
    Routes.emergencyContact: 5,
  };

  void updateProgressForRoute(String route) {
    final step = _routeStepMap[route];
    if (step != null) {
      setStep(step);
    }
  }
}
