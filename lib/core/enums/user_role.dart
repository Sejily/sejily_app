enum UserRole {
  patient("PATIENT"),
  healthcareProvider("HEALTHCARE_PROVIDER"),
  emergencyContact("EMERGENCY_CONTACT"),
  systemAdmin("SYSTEM_ADMIN");

  const UserRole(this.value);
  final String value;
}
