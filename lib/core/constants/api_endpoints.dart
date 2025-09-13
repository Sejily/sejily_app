class ApiEndpoints {
  //* Authentication
  static const String register = "/auth/register";
  static const String login = "/auth/login";
  static const String forgotPassword = "/auth/forgot-password";
  static const String resetPassword = "/auth/reset-password";
  static const String verifyOtp = "/auth/verify-otp";
  static const String resendOtp = "/auth/resend-otp";
  static const String completeDoctorRegistration =
      "/auth/completeRegisterDoctor";
  static const String completePatientRegistration =
      "/auth/completeRegisterPatient";
  static const String refreshToken = "/auth/refresh";
  static const String baseUrl = "https://sejily-server.vercel.app";

  // profile
  static const String patientProfile = "/users/profile/patient";
  static const String authProfile = "/auth/profile";

  //* AI
  static const String aiUpload = '/ai/ai/file/upload';
  static const String aiSearch = '/ai/search';
  static const String aiFhirSearch = '/ai/fhir/search';
  static const String aiDocumentHead = '/ai/document/';
  static const String aiDocumentTail = '/extracted-data';
  static const String aiInsights = '/ai/insights';

  //* Document
  static const String documents = '/documents';
  static const String documentsStats = '/documents/stats';
  static const String processingStatus = '/processing-status';
  static const String documentSearch = '/documents/search';
  static const String documentBulkDelete = '/documents/bulk/delete';
}
