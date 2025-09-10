class AppRegex {
  AppRegex._();

  /// Email validation regex pattern
  static final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  /// Phone number validation regex pattern (can be customized for specific formats)
  static final RegExp _phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]+$');

  /// Password strength regex patterns
  static final RegExp _uppercaseRegex = RegExp(r'[A-Z]');
  static final RegExp _lowercaseRegex = RegExp(r'[a-z]');
  static final RegExp _numberRegex = RegExp(r'\d');
  static final RegExp _specialCharRegex = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');

  /// Name validation regex pattern (letters and spaces only, including Arabic)
  static final RegExp _nameRegex = RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$');

  /// National ID validation regex pattern (numbers only)
  static final RegExp _nationalIdRegex = RegExp(r'^\d+$');

  // Email validation methods
  static bool isEmailValid(String email) => _emailRegex.hasMatch(email.trim());

  // Password validation methods
  static bool hasMinLength(String password, {int minLength = 8}) =>
      password.length >= minLength;

  static bool hasUpperCase(String password) =>
      _uppercaseRegex.hasMatch(password);

  static bool hasLowerCase(String password) =>
      _lowercaseRegex.hasMatch(password);

  static bool hasNumber(String password) => _numberRegex.hasMatch(password);

  static bool hasSpecialCharacter(String password) =>
      _specialCharRegex.hasMatch(password);

  // Name validation
  static bool isNameValid(String name) => _nameRegex.hasMatch(name.trim());

  // Phone validation
  static bool isPhoneValid(String phone) => _phoneRegex.hasMatch(phone.trim());

  // National ID validation
  static bool isNationalIdValid(String nationalId) =>
      _nationalIdRegex.hasMatch(nationalId.trim());

  // Password strength validation
  static bool isPasswordStrong(String password) {
    return hasMinLength(password) &&
        hasUpperCase(password) &&
        hasLowerCase(password) &&
        hasNumber(password) &&
        hasSpecialCharacter(password);
  }

  // Basic password validation (minimum requirements)
  static bool isPasswordValid(String password) {
    return hasMinLength(password, minLength: 6) &&
        (hasNumber(password) ||
            hasUpperCase(password) ||
            hasLowerCase(password));
  }
}
