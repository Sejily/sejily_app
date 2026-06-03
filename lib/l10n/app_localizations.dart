import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// First onboarding screen title
  ///
  /// In en, this message translates to:
  /// **'Your path to smarter and safer healthcare.'**
  String get onboardingTitle1;

  /// First onboarding screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Save your medical record, track your health, and share your data with your doctor with complete confidence.'**
  String get onboardingSubtitle1;

  /// Second onboarding screen title
  ///
  /// In en, this message translates to:
  /// **'Your medical data in your hands... and encrypted with the strongest technologies!'**
  String get onBoardingTitle2;

  /// Second onboarding screen subtitle
  ///
  /// In en, this message translates to:
  /// **'No need to worry anymore - your privacy is our priority'**
  String get onBoardingSubtitle2;

  /// Third onboarding screen title
  ///
  /// In en, this message translates to:
  /// **'Everything you need for your health in one place... and one click away.'**
  String get onBoardingTitle3;

  /// Third onboarding screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Upload your medical file and let artificial intelligence organize it for you!'**
  String get onBoardingSubtitle3;

  /// Button text for next action
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Button text for skip action
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// Button text for back/return action
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Button text for finish action
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// Button text for save action
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Button text for cancel action
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Button text for confirm action
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Button text for verify action
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// Button text for saving contact information
  ///
  /// In en, this message translates to:
  /// **'Save Contact Information'**
  String get saveContactInfo;

  /// Loading state text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Checking/validating state text
  ///
  /// In en, this message translates to:
  /// **'Checking...'**
  String get checking;

  /// Password change in progress text
  ///
  /// In en, this message translates to:
  /// **'Changing password...'**
  String get changing;

  /// Logout confirmation dialog message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get sureToLogout;

  /// Role selection screen title
  ///
  /// In en, this message translates to:
  /// **'Select Your Role'**
  String get selectYourRole;

  /// Role selection screen description
  ///
  /// In en, this message translates to:
  /// **'Choose your role to help us provide you with the appropriate experience.'**
  String get chooseYourRoleTo;

  /// Doctor role option
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get doctor;

  /// User role option
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// New user button text on onboarding
  ///
  /// In en, this message translates to:
  /// **'New User'**
  String get newUser;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Welcome back message on login screen
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get welcomeBack;

  /// Welcome message with user name
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}!'**
  String welcome(String name);

  /// Login screen instruction text
  ///
  /// In en, this message translates to:
  /// **'Enter the following data to access your account!'**
  String get enterNextData;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Forgot password link text
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgetPassword;

  /// No account prompt on login screen
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// Register now link/button text
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get registerNow;

  /// Social signup section header
  ///
  /// In en, this message translates to:
  /// **'Or sign up with'**
  String get orSignupWith;

  /// Google social login option
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// iCloud social login option
  ///
  /// In en, this message translates to:
  /// **'iCloud'**
  String get icloud;

  /// Personal profile completion screen title
  ///
  /// In en, this message translates to:
  /// **'Complete Your Personal Profile'**
  String get completePersonalProfile;

  /// Personal profile completion screen description
  ///
  /// In en, this message translates to:
  /// **'Help us know you better to provide a personalized experience.'**
  String get helpUsProvidePersonalizedExperience;

  /// Complete profile screen title
  ///
  /// In en, this message translates to:
  /// **'Complete Your Personal Information'**
  String get completeProfile;

  /// Complete button text
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// Medical profile completion instruction text
  ///
  /// In en, this message translates to:
  /// **'Please complete your personal information to follow up on your condition efficiently and ensure the best experience.'**
  String get helpUsProvidePersonal;

  /// Edit profile menu option
  ///
  /// In en, this message translates to:
  /// **'Edit Your Profile'**
  String get editProfile;

  /// Emergency contacts menu option
  ///
  /// In en, this message translates to:
  /// **'Emergency Contacts'**
  String get emergency;

  /// Notifications menu option
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notification;

  /// Help and support menu option
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get help;

  /// Terms and conditions menu option
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get terms;

  /// Logout menu option
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Medical history field label
  ///
  /// In en, this message translates to:
  /// **'Medical History'**
  String get medicalState;

  /// Allergies/Sensitivities field label
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get sensitive;

  /// Height field label
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// Weight field label
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// Blood type field label
  ///
  /// In en, this message translates to:
  /// **'Blood Type'**
  String get bloodType;

  /// Save changes button text
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// List of blood type options
  ///
  /// In en, this message translates to:
  /// **'A+, A-, B+, B-, O+, O-, AB+, AB-'**
  String get bloodTypes;

  /// Address field label
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// Date of birth field label
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// Phone number field label
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// Gender field label
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// Male gender option
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// Female gender option
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// Nationality field label
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get nationality;

  /// Egyptian nationality option
  ///
  /// In en, this message translates to:
  /// **'Egyptian'**
  String get egyptian;

  /// National ID number field label
  ///
  /// In en, this message translates to:
  /// **'National ID Number'**
  String get nationalIdNumber;

  /// ID photo upload section title
  ///
  /// In en, this message translates to:
  /// **'ID Photo'**
  String get profilePictureUpload;

  /// File upload area instruction text
  ///
  /// In en, this message translates to:
  /// **'Drop file or browse'**
  String get dragDropOrTapToUpload;

  /// Image upload requirements text
  ///
  /// In en, this message translates to:
  /// **'Format: .jpeg, .png & Maximum file size: 25 MB'**
  String get imageUploadCriteria;

  /// National ID upload requirements text
  ///
  /// In en, this message translates to:
  /// **'Format: .jpeg, .png & Maximum file size: 25 MB. Please upload a clear ID photo'**
  String get imageUploadNationalId;

  /// Browse files button text
  ///
  /// In en, this message translates to:
  /// **'Browse Files'**
  String get browseFiles;

  /// Personal photo upload section title
  ///
  /// In en, this message translates to:
  /// **'Upload Personal Photo'**
  String get personalPictureUpload;

  /// Personal photo field label
  ///
  /// In en, this message translates to:
  /// **'Personal Photo'**
  String get personalPicture;

  /// Personal photo upload instructions
  ///
  /// In en, this message translates to:
  /// **'Please upload the file in jpeg and png format and the maximum file size less than 25 MB.'**
  String get uploadPersonalPictureDescription;

  /// Upload file button/section title
  ///
  /// In en, this message translates to:
  /// **'Upload File'**
  String get uploadFile;

  /// Browse button text
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get browse;

  /// Warning dialog/card title
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// Medical file upload warning instructions
  ///
  /// In en, this message translates to:
  /// **'Please enter your medical information in chronological order.\nIf you upload images, please take clear pictures.\nPlease upload analyses together and X-rays together separately for easy review.'**
  String get warningDescription;

  /// Document upload requirements text
  ///
  /// In en, this message translates to:
  /// **'Format: doc, docx, pdf & Maximum file size: 25 MB'**
  String get uploadfileDescription;

  /// Add emergency contact button/screen title
  ///
  /// In en, this message translates to:
  /// **'Add Emergency Contact'**
  String get addEmergencyContact;

  /// Emergency contact screen description
  ///
  /// In en, this message translates to:
  /// **'Add an emergency contact and stay safe.'**
  String get addEmergencyContactDescription;

  /// Emergency contact location permission warning
  ///
  /// In en, this message translates to:
  /// **'If doctors request access to your medical information from the emergency contact, the application will have the ability to access your geographical location'**
  String get warningemergency;

  /// Emergency contact name field label
  ///
  /// In en, this message translates to:
  /// **'Emergency Contact Name'**
  String get emergencyContactName;

  /// Emergency contact phone field label
  ///
  /// In en, this message translates to:
  /// **'Emergency Contact Phone'**
  String get emergencyContactPhone;

  /// Relationship to emergency contact field label
  ///
  /// In en, this message translates to:
  /// **'Relationship'**
  String get relationshipToEmergencyContact;

  /// Relative relationship option
  ///
  /// In en, this message translates to:
  /// **'Relative'**
  String get relative;

  /// Add another emergency contact button text
  ///
  /// In en, this message translates to:
  /// **'Add Another Contact'**
  String get addAnotherContact;

  /// Relationship dropdown placeholder
  ///
  /// In en, this message translates to:
  /// **'Choose Relationship'**
  String get chooseRelationShip;

  /// List of relationship options
  ///
  /// In en, this message translates to:
  /// **'Father/Mother, Son/Daughter, Husband/Wife, Brother/Sister, Uncle/Aunt, Cousin, Grandfather/Grandmother, Friend/Colleague, Doctor, Hospital, Other'**
  String get relationshipOptions;

  /// Data review screen title
  ///
  /// In en, this message translates to:
  /// **'Your data is currently under review!'**
  String get dataUnderReview;

  /// Data review screen description
  ///
  /// In en, this message translates to:
  /// **'Our team is reviewing your information to ensure accuracy and security. This may take up to 48 hours. You will receive an email notification when your data has been reviewed.'**
  String get reviewDataDescription;

  /// Browse main page button text
  ///
  /// In en, this message translates to:
  /// **'Browse Main Page'**
  String get browseMainPage;

  /// Privacy policies link text
  ///
  /// In en, this message translates to:
  /// **'Browse Usage and Privacy Policies'**
  String get browseUsageAndPrivacyPolicies;

  /// Verification code timeout display
  ///
  /// In en, this message translates to:
  /// **'00:59'**
  String get verificationCodeTimeout;

  /// Registration screen title
  ///
  /// In en, this message translates to:
  /// **'Register Now for Free!'**
  String get registerNowFree;

  /// Registration screen instruction text
  ///
  /// In en, this message translates to:
  /// **'Enter the following information to create a new account. Start now, don\'t hesitate!'**
  String get enterDataToCreateAccount;

  /// Full name field label
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullNameLabel;

  /// Email address field label
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// Create account button text
  ///
  /// In en, this message translates to:
  /// **'Create New Account'**
  String get createNewAccount;

  /// Terms agreement text part 1
  ///
  /// In en, this message translates to:
  /// **'By clicking '**
  String get agreeToUsageAndPrivacyPolicies1;

  /// Terms agreement text part 2
  ///
  /// In en, this message translates to:
  /// **', you agree to '**
  String get agreeToUsageAndPrivacyPolicies2;

  /// Privacy policies link text
  ///
  /// In en, this message translates to:
  /// **'Usage and Privacy Policies'**
  String get usageAndPrivacyPolicies;

  /// Already have account prompt
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccountAlready;

  /// Login now link text
  ///
  /// In en, this message translates to:
  /// **'Login Now'**
  String get loginNow;

  /// Social login section header
  ///
  /// In en, this message translates to:
  /// **'Or login with'**
  String get orLoginWith;

  /// OTP verification screen title
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code'**
  String get enterVerificationCode;

  /// Verification code sent message
  ///
  /// In en, this message translates to:
  /// **'We have sent a verification code to the following email'**
  String get verificationCodeSent;

  /// Didn't receive code prompt
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive a code?'**
  String get didntReceiveCode;

  /// Resend code button text
  ///
  /// In en, this message translates to:
  /// **'Request New Code'**
  String get requestNewCode;

  /// Password reset screen title
  ///
  /// In en, this message translates to:
  /// **'Password Recovery!'**
  String get passwordResetTitle;

  /// Password reset screen description
  ///
  /// In en, this message translates to:
  /// **'Enter your email address to recover your password!'**
  String get passwordResetDescription;

  /// Send verification code button text
  ///
  /// In en, this message translates to:
  /// **'Send Verification Code'**
  String get sendVerificationCode;

  /// New password screen title
  ///
  /// In en, this message translates to:
  /// **'Enter New Password!'**
  String get enterNewPassword;

  /// New password screen description
  ///
  /// In en, this message translates to:
  /// **'Enter your new password. It must be at least 8 characters!'**
  String get enterNewPasswordDescription;

  /// New password field label
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// Change password button text
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// Remember password link text
  ///
  /// In en, this message translates to:
  /// **'Remember Password?'**
  String get forgotPassword;

  /// Success dialog title
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get congratulations;

  /// Password reset success message
  ///
  /// In en, this message translates to:
  /// **'Your account password has been changed successfully. You can now go back and login again!'**
  String get passwordResetSuccessDescription;

  /// Registration success message
  ///
  /// In en, this message translates to:
  /// **'Registration completed successfully!'**
  String get registrationCompletedSuccessfully;

  /// Registration in progress text
  ///
  /// In en, this message translates to:
  /// **'Completing registration...'**
  String get completingRegistration;

  /// Emergency contact save success message
  ///
  /// In en, this message translates to:
  /// **'Emergency contact information saved!'**
  String get emergencyContactSaved;

  /// Registration failure message
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get registrationFailed;

  /// General error message
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get generalError;

  /// Required field validation message
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// Invalid email validation message
  ///
  /// In en, this message translates to:
  /// **'Email is invalid'**
  String get invalidEmail;

  /// Password too short validation message
  ///
  /// In en, this message translates to:
  /// **'Password is too short'**
  String get passwordTooShort;

  /// Passwords mismatch validation message
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// Invalid phone validation message
  ///
  /// In en, this message translates to:
  /// **'Phone number is invalid'**
  String get invalidPhoneNumber;

  /// Enter password validation message
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// Enter confirm password validation message
  ///
  /// In en, this message translates to:
  /// **'Enter confirm password'**
  String get enterConfirmPassword;

  /// Enter email validation message
  ///
  /// In en, this message translates to:
  /// **'Enter email address'**
  String get enterEmailAddress;

  /// Enter valid email validation message
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get enterValidEmail;

  /// Password missing uppercase validation message
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter'**
  String get passwordMissingUppercase;

  /// Password missing lowercase validation message
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one lowercase letter'**
  String get passwordMissingLowercase;

  /// Password missing special character validation message
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one special character'**
  String get passwordMissingSpecialChar;

  /// Enter digit validation message
  ///
  /// In en, this message translates to:
  /// **'Enter a number'**
  String get enterDigit;

  /// List of medical specialization options
  ///
  /// In en, this message translates to:
  /// **'General Medicine, Pediatrics, Obstetrics and Gynecology, General Surgery, Cardiology, Neurology, Orthopedics, Dermatology, Ophthalmology, Otolaryngology, Psychiatry, Dentistry, Neurosurgery, Cardiac Surgery, Plastic Surgery, Radiology, Anesthesiology, Emergency Medicine, Internal Medicine, Nephrology, Oncology'**
  String get specializationOptions;

  /// Professional profile completion screen title
  ///
  /// In en, this message translates to:
  /// **'Complete Your Professional Profile!'**
  String get completeProfessionalProfile;

  /// Professional profile completion description
  ///
  /// In en, this message translates to:
  /// **'Add your information to build a complete professional profile.'**
  String get addProfessionalInfoDescription;

  /// Hospital name field label
  ///
  /// In en, this message translates to:
  /// **'Hospital Name'**
  String get hospitalName;

  /// City field label
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// Specialization field label
  ///
  /// In en, this message translates to:
  /// **'Specialization'**
  String get specialization;

  /// Medical license number field label
  ///
  /// In en, this message translates to:
  /// **'Medical License Number'**
  String get medicalLicenseNumber;

  /// Upload medical license section title
  ///
  /// In en, this message translates to:
  /// **'Upload Your Medical License'**
  String get uploadMedicalLicense;

  /// Medical license number placeholder
  ///
  /// In en, this message translates to:
  /// **'Enter Medical License Number'**
  String get enterMedicalLicenseNumber;

  /// Medical license document label
  ///
  /// In en, this message translates to:
  /// **'Medical License Card'**
  String get medicalLicenseDocument;

  /// Medical license upload field label
  ///
  /// In en, this message translates to:
  /// **'Medical License Card'**
  String get medicalLicenseUpload;

  /// Medical license upload instructions
  ///
  /// In en, this message translates to:
  /// **'Please upload the file in jpeg or png format and make sure the file size is less than 25 MB.'**
  String get medicalLicenseDescription;

  /// File type selection dialog title
  ///
  /// In en, this message translates to:
  /// **'What type of file is this?'**
  String get fileType;

  /// X-ray file type option
  ///
  /// In en, this message translates to:
  /// **'X-ray'**
  String get rays;

  /// Analysis/lab report file type option
  ///
  /// In en, this message translates to:
  /// **'Analysis'**
  String get analysis;

  /// Network error message
  ///
  /// In en, this message translates to:
  /// **'Network connection error'**
  String get networkError;

  /// Server error message
  ///
  /// In en, this message translates to:
  /// **'Server error'**
  String get serverError;

  /// Unknown error message
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred'**
  String get unknownError;

  /// Upload failure message
  ///
  /// In en, this message translates to:
  /// **'File upload failed'**
  String get uploadFailed;

  /// Home tab label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Files tab label
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get file;

  /// Profile tab label
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Connection timeout error message
  ///
  /// In en, this message translates to:
  /// **'Connection timed out. Please try again'**
  String get connectionTimeoutError;

  /// Send timeout error message
  ///
  /// In en, this message translates to:
  /// **'Send timed out. Please try again'**
  String get sendTimeoutError;

  /// Receive timeout error message
  ///
  /// In en, this message translates to:
  /// **'Receive timed out. Please try again'**
  String get receiveTimeoutError;

  /// Bad certificate error message
  ///
  /// In en, this message translates to:
  /// **'Invalid security certificate'**
  String get badCertificateError;

  /// Cancelled request error message
  ///
  /// In en, this message translates to:
  /// **'Request was cancelled'**
  String get cancelledRequestError;

  /// No internet connection error message
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your connection and try again'**
  String get connectionErrorMsg;

  /// Unexpected error message
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again'**
  String get unexpectedError;

  /// Login success message
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccessful;

  /// Login error message
  ///
  /// In en, this message translates to:
  /// **'An error occurred during login, please try again'**
  String get loginError;

  /// Save success message
  ///
  /// In en, this message translates to:
  /// **'Saved successfully'**
  String get savedSuccessfully;

  /// Save failure message
  ///
  /// In en, this message translates to:
  /// **'Save failed'**
  String get saveFailed;

  /// Save error message
  ///
  /// In en, this message translates to:
  /// **'An error occurred, please try again'**
  String get saveError;

  /// Saving in progress message
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get savingInProgress;

  /// Verification success message
  ///
  /// In en, this message translates to:
  /// **'Code verified successfully'**
  String get verificationSuccessful;

  /// Incorrect verification code message
  ///
  /// In en, this message translates to:
  /// **'Verification code is incorrect, please try again'**
  String get verificationCodeIncorrect;

  /// Code resent success message
  ///
  /// In en, this message translates to:
  /// **'Verification code resent successfully'**
  String get verificationCodeResent;

  /// Resend code failure message
  ///
  /// In en, this message translates to:
  /// **'Failed to resend code. Please try again.'**
  String get resendCodeFailed;

  /// Sending in progress message
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get sending;

  /// Password change success message
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get passwordChangeSuccessful;

  /// Password change error message
  ///
  /// In en, this message translates to:
  /// **'An error occurred while changing password, please try again'**
  String get passwordChangeError;

  /// Verification code sent success message
  ///
  /// In en, this message translates to:
  /// **'Verification code sent successfully'**
  String get verificationCodeSentSuccessfully;

  /// Forgot password error message
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred, please try again'**
  String get forgotPasswordError;

  /// Login failed message
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// Blood type label with colon
  ///
  /// In en, this message translates to:
  /// **'Blood Type: '**
  String get bloodTypeLabel;

  /// Height label with colon
  ///
  /// In en, this message translates to:
  /// **'Height: '**
  String get heightLabel;

  /// Weight label with colon
  ///
  /// In en, this message translates to:
  /// **'Weight: '**
  String get weightLabel;

  /// File size error message
  ///
  /// In en, this message translates to:
  /// **'Files must not exceed 25 MB'**
  String get fileSizeError;

  /// File path error message
  ///
  /// In en, this message translates to:
  /// **'File path is invalid'**
  String get filePathError;

  /// Upload failed unexpected response message
  ///
  /// In en, this message translates to:
  /// **'File upload failed: unexpected response'**
  String get uploadFailedUnexpectedResponse;

  /// Upload failed no response message
  ///
  /// In en, this message translates to:
  /// **'File upload failed: no response'**
  String get uploadFailedNoResponse;

  /// Upload failed general message prefix
  ///
  /// In en, this message translates to:
  /// **'File upload failed: '**
  String get uploadFailedGeneral;

  /// Uploading file message prefix
  ///
  /// In en, this message translates to:
  /// **'Uploading: '**
  String get uploadingFile;

  /// Data load error message prefix
  ///
  /// In en, this message translates to:
  /// **'Error loading data: '**
  String get dataLoadError;

  /// Analyze document button text
  ///
  /// In en, this message translates to:
  /// **'Analyze Medical Document'**
  String get analyzeMedicalDocument;

  /// Analyzing document in progress message
  ///
  /// In en, this message translates to:
  /// **'Analyzing medical document...'**
  String get analyzingMedicalDocument;

  /// Analysis error message
  ///
  /// In en, this message translates to:
  /// **'An error occurred while analyzing the document'**
  String get analysisError;

  /// Retry instruction text
  ///
  /// In en, this message translates to:
  /// **'Please try again'**
  String get pleaseRetry;

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryLabel;

  /// No medical data message
  ///
  /// In en, this message translates to:
  /// **'No medical data to display'**
  String get noMedicalDataToShow;

  /// No extractable info message
  ///
  /// In en, this message translates to:
  /// **'The document does not contain extractable medical information'**
  String get noExtractableInfo;

  /// Patient information section title
  ///
  /// In en, this message translates to:
  /// **'Patient Information'**
  String get patientInfo;

  /// Unspecified patient placeholder
  ///
  /// In en, this message translates to:
  /// **'Unspecified patient'**
  String get unspecifiedPatient;

  /// Gender label with colon
  ///
  /// In en, this message translates to:
  /// **'Gender: '**
  String get genderLabel;

  /// Prescribed medications section title
  ///
  /// In en, this message translates to:
  /// **'Prescribed Medications'**
  String get prescribedMedications;

  /// Unspecified medication placeholder
  ///
  /// In en, this message translates to:
  /// **'Unspecified medication'**
  String get unspecifiedMedication;

  /// Unspecified dosage placeholder
  ///
  /// In en, this message translates to:
  /// **'Unspecified dosage'**
  String get unspecifiedDosage;

  /// Unspecified general placeholder
  ///
  /// In en, this message translates to:
  /// **'Unspecified'**
  String get unspecified;

  /// Google Drive login failure message
  ///
  /// In en, this message translates to:
  /// **'Failed to login to Google Drive'**
  String get googleDriveLoginFailed;

  /// Google Drive file picker title
  ///
  /// In en, this message translates to:
  /// **'Select Files from Google Drive'**
  String get selectFilesFromGoogleDrive;

  /// No files message
  ///
  /// In en, this message translates to:
  /// **'No files to display'**
  String get noFilesToShow;

  /// No name placeholder
  ///
  /// In en, this message translates to:
  /// **'No name'**
  String get noName;

  /// Number of files selected
  ///
  /// In en, this message translates to:
  /// **'Selected {count} file(s)'**
  String filesSelected(int count);

  /// Add files button text
  ///
  /// In en, this message translates to:
  /// **'Add Files'**
  String get addFiles;

  /// Analyze file button text
  ///
  /// In en, this message translates to:
  /// **'Analyze Medical File'**
  String get analyzeFile;

  /// No emergency contacts message
  ///
  /// In en, this message translates to:
  /// **'No emergency contacts'**
  String get noEmergencyContacts;

  /// Emergency contact details screen title
  ///
  /// In en, this message translates to:
  /// **'Emergency Contact Details'**
  String get emergencyContactDetails;

  /// Name label with colon
  ///
  /// In en, this message translates to:
  /// **'Name: '**
  String get nameLabel;

  /// Phone label with colon
  ///
  /// In en, this message translates to:
  /// **'Phone: '**
  String get phoneLabel;

  /// Relationship label with colon
  ///
  /// In en, this message translates to:
  /// **'Relationship: '**
  String get relationLabel;

  /// Delete emergency contact button text
  ///
  /// In en, this message translates to:
  /// **'Delete Emergency Contact'**
  String get deleteEmergencyContact;

  /// Generic error occurred message
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorOccurred;

  /// Enter complete verification code message
  ///
  /// In en, this message translates to:
  /// **'Please enter the complete verification code'**
  String get pleaseEnterVerificationCode;

  /// Unexpected error retry message
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again'**
  String get unexpectedErrorRetry;

  /// Invalid user role error message
  ///
  /// In en, this message translates to:
  /// **'Invalid user role. Please try again.'**
  String get invalidUserRole;

  /// Registration error message prefix
  ///
  /// In en, this message translates to:
  /// **'An error occurred during registration: '**
  String get registrationError;

  /// Enter phone number placeholder
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhoneNumber;

  /// Image selected success message
  ///
  /// In en, this message translates to:
  /// **'Image selected successfully'**
  String get imageSelectedSuccessfully;

  /// Change image button text
  ///
  /// In en, this message translates to:
  /// **'Change Image'**
  String get changeImage;

  /// Male gender value
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get maleGender;

  /// Female gender value
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get femaleGender;

  /// Upload personal photo validation message
  ///
  /// In en, this message translates to:
  /// **'Please upload a personal photo'**
  String get pleaseUploadPersonalPhoto;

  /// Upload national ID validation message
  ///
  /// In en, this message translates to:
  /// **'Please upload a national ID photo'**
  String get pleaseUploadNationalId;

  /// Passwords do not match error message
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatchError;

  /// Please enter email validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterEmail;

  /// Please enter email and password validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter your email and password'**
  String get pleaseEnterEmailAndPassword;

  /// Document details screen title
  ///
  /// In en, this message translates to:
  /// **'Document Details'**
  String get documentDetails;

  /// Unspecified document placeholder
  ///
  /// In en, this message translates to:
  /// **'Unspecified document'**
  String get unspecifiedDocument;

  /// File type field label
  ///
  /// In en, this message translates to:
  /// **'File Type'**
  String get fileTypeLabel;

  /// Upload date label
  ///
  /// In en, this message translates to:
  /// **'Upload Date'**
  String get uploadDate;

  /// Processing date label
  ///
  /// In en, this message translates to:
  /// **'Processing Date'**
  String get processingDate;

  /// Extracted medical data section title
  ///
  /// In en, this message translates to:
  /// **'Extracted Medical Data'**
  String get extractedMedicalData;

  /// Extraction accuracy label
  ///
  /// In en, this message translates to:
  /// **'Extraction Accuracy: '**
  String get extractionAccuracy;

  /// Patient ID label
  ///
  /// In en, this message translates to:
  /// **'Patient ID'**
  String get patientId;

  /// Status label
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// Active status value
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// Inactive status value
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// Name label
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Report type label
  ///
  /// In en, this message translates to:
  /// **'Report Type'**
  String get reportType;

  /// Report status label
  ///
  /// In en, this message translates to:
  /// **'Report Status'**
  String get reportStatus;

  /// Summary label
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// Report date label
  ///
  /// In en, this message translates to:
  /// **'Report Date'**
  String get reportDate;

  /// Purpose label
  ///
  /// In en, this message translates to:
  /// **'Purpose'**
  String get purpose;

  /// Identifier label
  ///
  /// In en, this message translates to:
  /// **'Identifier'**
  String get identifier;

  /// Resource type label
  ///
  /// In en, this message translates to:
  /// **'Resource Type'**
  String get resourceType;

  /// Additional information label
  ///
  /// In en, this message translates to:
  /// **'Additional Information'**
  String get additionalInfo;

  /// Document ID label
  ///
  /// In en, this message translates to:
  /// **'Document ID'**
  String get documentId;

  /// HTTP 400 error message
  ///
  /// In en, this message translates to:
  /// **'Please check the entered data'**
  String get badRequestError;

  /// HTTP 401 error message
  ///
  /// In en, this message translates to:
  /// **'Unauthorized access. Please login again'**
  String get unauthorizedError;

  /// HTTP 403 error message
  ///
  /// In en, this message translates to:
  /// **'Access to this resource is forbidden'**
  String get forbiddenError;

  /// HTTP 404 error message
  ///
  /// In en, this message translates to:
  /// **'The requested resource was not found'**
  String get notFoundError;

  /// HTTP 409 error message
  ///
  /// In en, this message translates to:
  /// **'Data conflict. Please try again'**
  String get conflictError;

  /// HTTP 500 error message
  ///
  /// In en, this message translates to:
  /// **'Internal server error. Please try again later'**
  String get internalServerError;

  /// HTTP 503 error message
  ///
  /// In en, this message translates to:
  /// **'Service is currently unavailable. Please try again later'**
  String get serviceUnavailableError;

  /// Email invalid API error message
  ///
  /// In en, this message translates to:
  /// **'Email is invalid'**
  String get emailInvalidError;

  /// Password required API error message
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequiredError;

  /// Phone invalid API error message
  ///
  /// In en, this message translates to:
  /// **'Phone number is invalid'**
  String get phoneInvalidError;

  /// Account exists API error message
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists'**
  String get accountExistsError;

  /// Account not found API error message
  ///
  /// In en, this message translates to:
  /// **'No account found with this email'**
  String get accountNotFoundError;

  /// Invalid credentials API error message
  ///
  /// In en, this message translates to:
  /// **'Email or password is invalid'**
  String get invalidCredentialsError;

  /// Account not verified API error message
  ///
  /// In en, this message translates to:
  /// **'Account is not verified. Please check your email'**
  String get accountNotVerifiedError;

  /// Invalid verification code API error message
  ///
  /// In en, this message translates to:
  /// **'Verification code is invalid'**
  String get verificationCodeInvalidError;

  /// Expired verification code API error message
  ///
  /// In en, this message translates to:
  /// **'Verification code has expired'**
  String get verificationCodeExpiredError;

  /// Upload failed retry API error message
  ///
  /// In en, this message translates to:
  /// **'File upload failed. Please try again'**
  String get uploadFailedRetry;

  /// File size exceeded API error message
  ///
  /// In en, this message translates to:
  /// **'File size is too large. Maximum 25 MB'**
  String get fileSizeExceededError;

  /// File type not supported API error message
  ///
  /// In en, this message translates to:
  /// **'File type is not supported. Please use JPEG or PNG images'**
  String get fileTypeNotSupportedError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
