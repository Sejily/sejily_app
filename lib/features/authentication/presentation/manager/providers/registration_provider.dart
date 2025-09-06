import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/features/authentication/data/models/full_doctor_registration_request.dart';
import 'package:sejily/features/authentication/data/models/full_patient_registration_request.dart';

final patientRegistrationProvider =
    StateProvider<FullPatientRegistrationRequest>((ref) {
      return FullPatientRegistrationRequest();
    });

final doctorRegistrationProvider = StateProvider<FullDoctorRegistrationRequest>(
  (ref) {
    return FullDoctorRegistrationRequest();
  },
);
