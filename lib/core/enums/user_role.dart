enum UserRole {
  patient('PATIENT'),
  healthcareProvider('HEALTHCARE_PROVIDER'),
  emergencyContact('EMERGENCY_CONTACT'),
  systemAdmin('SYSTEM_ADMIN');

  final String value;
  const UserRole(this.value);

  static UserRole fromValue(String? value) {
    if (value == null) return UserRole.patient;

    return UserRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => UserRole.patient,
    );
  }

  bool get isPatient => this == UserRole.patient;
  bool get isHealthcareProvider => this == UserRole.healthcareProvider;
  bool get isEmergencyContact => this == UserRole.emergencyContact;
  bool get isSystemAdmin => this == UserRole.systemAdmin;
}
