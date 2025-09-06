import 'package:sejily/core/helpers/extensions.dart';
import 'package:sejily/core/utils/app_regex.dart';
import 'package:sejily/core/utils/app_strings.dart';

class AppValidators {
  AppValidators._();

  /// Email validation with enhanced features
  static String? emailValidator(String? value) {
    if (value.isNullOrEmpty()) {
      return AppStrings.enterEmailAddress;
    }

    if (!AppRegex.isEmailValid(value!.trim())) {
      return AppStrings.enterValidEmail;
    }

    return null;
  }

  /// Basic password validation (for login)
  static String? passwordValidator(String? value) {
    if (value.isNullOrEmpty()) {
      return AppStrings.enterPassword;
    }
    return null;
  }

  /// Strong password validation (for registration)
  static String? newPasswordValidator(String? value) {
    if (value.isNullOrEmpty()) {
      return AppStrings.enterPassword;
    }

    // Check minimum length (8 characters)
    if (!AppRegex.hasMinLength(value!)) {
      return AppStrings.passwordTooShort;
    }

    // Check for at least one uppercase letter
    if (!AppRegex.hasUpperCase(value)) {
      return AppStrings.passwordMissingUppercase;
    }

    // Check for at least one lowercase letter
    if (!AppRegex.hasLowerCase(value)) {
      return AppStrings.passwordMissingLowercase;
    }

    // Check for at least one special character
    if (!AppRegex.hasSpecialCharacter(value)) {
      return AppStrings.passwordMissingSpecialChar;
    }

    return null;
  }

  /// Name validation with enhanced features
  static String? nameValidator(String? value) {
    if (value.isNullOrEmpty()) {
      return AppStrings.fieldRequired;
    }

    if (!AppRegex.isNameValid(value!)) {
      return 'الاسم يجب أن يحتوي على حروف فقط';
    }

    return null;
  }

  /// Phone number validation
  static String? phoneNumberValidator(String? value) {
    if (value.isNullOrEmpty()) {
      return AppStrings.fieldRequired;
    }

    if (!AppRegex.isPhoneValid(value!)) {
      return AppStrings.invalidPhoneNumber;
    }

    return null;
  }

  /// National ID validation
  static String? nationalIdValidator(String? value) {
    if (value.isNullOrEmpty()) {
      return AppStrings.fieldRequired;
    }

    if (!AppRegex.isNationalIdValid(value!)) {
      return 'رقم الهوية يجب أن يحتوي على أرقام فقط';
    }

    return null;
  }

  /// OTP digit validation
  static String? otpDigitValidator(String? value) {
    if (value.isNullOrEmpty()) {
      return AppStrings.enterDigit;
    }
    return null;
  }

  /// Complete OTP validation
  static String? otpValidator(String? value) {
    final otp = value?.trim() ?? '';

    if (otp.isEmpty) {
      return 'يرجى إدخال رمز التحقق';
    }

    if (otp.length != 6) {
      return 'يرجى إدخال جميع الأرقام';
    }
    return null;
  }

  /// Check if OTP is complete for UI state (button activation)
  static bool isOtpComplete(String? value) {
    final otp = value?.trim() ?? '';
    return otp.length == 6 && otp.isNotEmpty && RegExp(r'^\d+$').hasMatch(otp);
  }

  /// General required field validation
  static String? requiredFieldValidator(String? value) {
    if (value.isNullOrEmpty()) {
      return 'هذا الحقل مطلوب';
    }
    return null;
  }
}
