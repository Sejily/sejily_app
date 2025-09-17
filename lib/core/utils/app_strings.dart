class AppStrings {
  AppStrings._();
  // ONBOARDING STRINGS
  static const String onboardingTitle1 =
      'طريقك إلى رعاية صحية أذكى وأكثر أمانًا.';
  static const String onboardingSubtitle1 =
      'إحفظ سجلك الطبي، تتبع صحتك، وشارك بياناتك مع طبيبك بثقة تامة.';

  static const String onBoardingTitle2 =
      'بياناتك الطبية بين يديك... ومشفرة بأقوي التقنيات!';
  static const String onBoardingSubtitle2 =
      'لا داعي للقلق بعد الآن - خصوصيتك هي أولويتنا';

  static const String onBoardingTitle3 =
      'كل ما تحتاجه لصحتك في مكان واحد... و بضغطة واحدة.';
  static const String onBoardingSubtitle3 =
      'ارفع ملفك الطبي, و دع الذكاء الاصطناعي ينظمه لك!';

  // NAVIGATION & COMMON ACTIONS
  static const String next = 'التالي';
  static const String skip = 'تخطي';
  static const String back = 'رجوع';
  static const String finish = 'إنهاء';
  static const String save = 'حفظ';
  static const String cancel = 'إلغاء';
  static const String confirm = 'تأكيد';
  static const String verify = 'تحقق';
  static const String saveContactInfo = 'حفظ بيانات الاتصال';
  static const String loading = 'تحميل...';
  static const String checking = 'جاري التحقق...';
  static const String changing = 'جاري تغيير كلمة المرور...';

  // USER ROLE SELECTION
  static const String selectYourRole = 'حدد دورك';
  static const String chooseYourRoleTo =
      '.اختر دورك لنساعدك في الحصول علي التجربةالمناسبة لك';
  static const String doctor = 'طبيب';
  static const String user = 'مستخدم';

  // AUTHENTICATION STRINGS
  static const String newUser = 'مستخدم جديد';
  static const String login = 'تسجيل الدخول';
  static const String welcomeBack = 'أهلا بعودتك!';
  static const String enterNextData =
      'ادخل البيانات التالية لتتمكن من الوصول إالي حسابك!';
  static const String email = 'البريد الإلكتروني';
  static const String password = 'كلمة المرور';
  static const String forgetPassword = 'نسيت كلمة المرور؟';
  static const String dontHaveAccount = 'ليس لديك حساب؟';
  static const String registerNow = 'سجل الآن';
  static const String orSignupWith = 'او تسجيل الدخول باستخدام';
  static const String google = 'Google';
  static const String icloud = 'Icloud';

  // PROFILE COMPLETION STRINGS
  static const String completePersonalProfile = 'أكمل ملفك الشخصي';
  static const String helpUsProvidePersonalizedExperience =
      'ساعدنا في معرفتك بشكل أفضل لتقديم تجربة مخصصة لك.';

  // PROFILE STRINGS
  static const String completeProfile = 'اكمال بياناتك الشخصية';
  static const String helpUsProvidePersonal =
      'تنبيه\nبرجاء اكمل بياناتك الشخصية لمتابعة حالتك بكفائة ولضمان افضل تجربة.';
  static const String editProfile = 'تعديل ملفك الشخصي';
  static const String emergency = 'جهات الطؤاري';
  static const String notification = 'الاشعارات';
  static const String help = 'المساعده والدعم';
  static const String terms = 'الشروط والاحكام';
  static const String logout = 'تسجيل الخروج';
  static const String medicalState = 'الحاله الطبيه';
  static const String sensitive = 'الحساسيه';
  static const String height = 'الطول';
  static const String weight = 'الوزن';
  static const String bloodType = 'فصيله الدم';
  static const String saveChanges = 'حفظ التغييرات';

  // BLOOD TYPE OPTIONS
  static const List<String> bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  // Personal Information Fields
  static const String address = 'العنوان';
  static const String dateOfBirth = 'تاريخ الميلاد';
  static const String phoneNumber = 'رقم الهاتف';
  static const String gender = 'الجنس';
  static const String male = 'ذكر';
  static const String female = 'أنثى';

  // Nationality & Identity
  static const String nationality = 'الجنسية';
  static const String egyptian = 'مصري';
  static const String nationalIdNumber = 'رقم الهوية';

  // Profile Picture Upload
  static const String profilePictureUpload = 'صورة الهوية';
  static const String dragDropOrTapToUpload = 'اسقاط ملف أو تصفح';
  static const String imageUploadCriteria =
      'التنسيق: .jpeg ، .png & الحد الأقصى لحجم الملف: 25 ميجا بايت';
  static const String imageUploadNationalId =
      'التنسيق: .jpeg ، .png & الحد الأقصى لحجم الملف: 25 ميجا بايت ويرجى تحميل صورة هوية واضحه';
  static const String browseFiles = 'تصفح الملفات';

  // Personal Picture Upload
  static const String personalPictureUpload = 'تحميل الصورة الشخصية';
  static const String personalPicture = 'الصورة الشخصية';
  static const String uploadPersonalPictureDescription =
      'يرجى تحميل الملف بتنسيق jpeg و png والحد الأقصى \nللملف أقل من 25 ميجابايت.';

  // Home User Upload
  static const String welcome = 'اهلا';
  static const String uploadFile = 'تحميل الملف';
  static const String browse = 'تصفح';
  static const String warning = 'تنبيه';
  static const String warningDescription =
      'برجاء إدخال معلوماتك الطبية بالترتيب الزمني\n. في حالة إدخال صور، برجاء التقاط صور واضحة\n. برجاء رفع التحاليل معًا، والأشعة معًا بشكل منفصل لسهولة المراجعة.';
  static const String uploadfileDescription =
      'التنسيق: doc , docx , pdf & الحد الأقصى لحجم الملف: 25 ميجا بايت';

  // EMERGENCY CONTACT STRINGS
  static const String addEmergencyContact = 'اضف جهة طوارئ';
  static const String addEmergencyContactDescription =
      'اضف جهة طوارئ .. و ابقي آمنا.';
  static const String warningemergency =
      'تنبيه \n في حال طلب الاطباء الوصول لمعلوماتك الطبيه من جهه الطوارئ سيكون للتطبيق امكانيه الوصول لموقعك الجغرافي';
  static const String emergencyContactName = 'اسم جهة الطوارئ';
  static const String emergencyContactPhone = 'رقم هاتف جهة الطوارئ';
  static const String relationshipToEmergencyContact = 'صلة القرابة';
  static const String relative = 'قريب';
  static const String addAnotherContact = 'اضف جهة أخرى';
  static const String chooseRelationShip = 'اختر صلة القرابة';
  static const List<String> relationshipOptions = [
    'الأب/الأم',
    'الابن/الابنة',
    'الزوج/الزوجة',
    'الأخ/الأخت',
    'العم/العمة',
    'الخال/الخالة',
    'الجد/الجدة',
    'صديق/زميل',
    'طبيب',
    'مستشفي',
    'أخري',
  ];

  // VERIFICATION STRINGS
  static const String dataUnderReview = 'بياناتك قيد المراجعة الآن!';
  static const String reviewDataDescription =
      'فريقنا بفحص معلوماتك للتأكد من دقة وأمانك. هذا قد\n يستغرق حتي 48 ساعة ستصلك رسالة على البريد في حال مراجعة \nالبيانات.';
  static const String browseMainPage = 'تصفح الصفحة الرئيسية';
  static const String browseUsageAndPrivacyPolicies =
      'تصفح سياسات الاستخدام والخصوصية';
  static const String verificationCodeTimeout = '00:59';

  // REGISTRATION STRINGS
  static const String registerNowFree = 'سجل الآن مجاناً!';
  static const String enterDataToCreateAccount =
      'ادخل البيانات التالية لانشاء حساب جديد. ابدأ الآن لما محالياً!';

  static const String fullNameLabel = 'الاسم بالكامل';
  static const String emailAddress = 'البريد الإلكتروني';
  static const String passwordLabel = 'كلمة المرور';
  static const String createNewAccount = 'تسجيل مستخدم جديد';
  static const String agreeToUsageAndPrivacyPolicies1 = 'بالضغط على ';
  static const String agreeToUsageAndPrivacyPolicies2 = '، فأنت توافق على ';
  static const String usageAndPrivacyPolicies = ' سياسة الاستخدام والخصوصية';
  static const String haveAccountAlready = 'لديك حساب بالفعل؟';
  static const String loginNow = 'سجل دخول الان';
  static const String orLoginWith = 'أو تسجيل الدخول باستخدام';

  // OTP VERIFICATION STRINGS
  static const String enterVerificationCode = 'ادخل رمز التحقق';
  static const String verificationCodeSent =
      'لقد قمنا بإرسال رمز التأكيد للبريد الالكتروني التالي';
  static const String didntReceiveCode = 'لم تستلم رمزاً؟';
  static const String requestNewCode = 'اطلب رمز جديد';

  // PASSWORD RESET STRINGS
  static const String passwordResetTitle = 'استعادة كلمة المرور!';
  static const String passwordResetDescription =
      'قم بادخال البريد الالكتروني لاستعادة كلمة المرور الخاصة بك!';
  static const String sendVerificationCode = 'إرسال رمز التحقق';
  static const String enterNewPassword = 'ادخل كلمة المرور الجديدة!';
  static const String enterNewPasswordDescription =
      'قم بادخال كلمة المرور الجديدة يجب أن تكون مكونة من 8 حروف!';
  static const String newPassword = 'كلمة المرور الجديدة';
  static const String confirmNewPassword = 'تأكيد كلمة المرور الجديدة';
  static const String changePassword = 'تغيير كلمة المرور';
  static const String forgotPassword = 'تذكرت كلمة المرور؟';

  // SUCCESS MESSAGES
  static const String congratulations = 'تهانينا!';
  static const String passwordResetSuccessDescription =
      'لقد تم تغيير كلمة مرور حسابك بنجاح، يمكنك الآن العودة وتسجيل الدخول من جديد!';
  static const String registrationCompletedSuccessfully =
      'تم إتمام التسجيل بنجاح!';
  static const String completingRegistration = 'جاري إتمام التسجيل...';
  static const String emergencyContactSaved = 'تم حفظ بيانات الاتصال الطارئ!';
  static const String registrationFailed = 'فشل في إتمام التسجيل';
  static const String generalError = 'حدث خطأ. يرجى المحاولة مرة أخرى.';

  // VALIDATION MESSAGES
  static const String fieldRequired = 'هذا الحقل مطلوب';
  static const String invalidEmail = 'البريد الإلكتروني غير صحيح';
  static const String passwordTooShort = 'كلمة المرور قصيرة جداً';
  static const String passwordsDoNotMatch = 'كلمات المرور غير متطابقة';
  static const String invalidPhoneNumber = 'رقم الهاتف غير صحيح';

  // Enhanced password validation messages
  static const String enterPassword = 'ادخل كلمة المرور';
  static const String enterConfirmPassword = 'ادخل تأكيد كلمة المرور';
  static const String enterEmailAddress = 'ادخل البريد الإلكتروني';
  static const String enterValidEmail = 'ادخل بريد إلكتروني صحيح';
  static const String passwordMissingUppercase =
      'كلمة المرور يجب أن تحتوي على حرف كبير واحد على الأقل';
  static const String passwordMissingLowercase =
      'كلمة المرور يجب أن تحتوي على حرف صغير واحد على الأقل';
  static const String passwordMissingSpecialChar =
      'كلمة المرور يجب أن تحتوي على رمز خاص واحد على الأقل';
  static const String enterDigit = 'ادخل الرقم';

  // DOCTOR PROFILE STRINGS
  static const List<String> specializationOptions = [
    'الطب العام',
    'طب الأطفال',
    'طب النساء والولادة',
    'جراحة عامة',
    'طب القلب',
    'طب الأعصاب',
    'طب العظام',
    'طب الجلدية',
    'طب العيون',
    'طب الأنف والأذن والحنجرة',
    'طب النفسية',
    'طب الأسنان',
    'جراحة المخ والأعصاب',
    'جراحة القلب',
    'جراحة التجميل',
    'طب الأشعة',
    'طب التخدير',
    'طب الطوارئ',
    'طب الأمراض الباطنة',
    'طب الكلى',
    'طب الأورام',
  ];
  static const String completeProfessionalProfile = 'اكمل بياناتك المهنية!';
  static const String addProfessionalInfoDescription =
      'أضف معلوماتك لبناء ملف تعريفي كامل.';
  static const String hospitalName = 'اسم المستشفى';
  static const String city = 'المدينة';
  static const String specialization = 'التخصص';
  static const String medicalLicenseNumber = 'رقم الترخيص الطبي';
  static const String uploadMedicalLicense = 'ارفع ترخيصك الطبي';
  static const String enterMedicalLicenseNumber = 'ادخل رقم الترخيص الطبي';
  static const String medicalLicenseDocument = 'بطاقة نقابة الاطباء';
  static const String medicalLicenseUpload = 'بطاقة نقابة الاطباء';
  static const String medicalLicenseDescription =
      'يرجى تحميل الملف بتنسيق jpeg أو png والتأكد من أن حجم الملف أقل من 25 ميجابايت.';

  // HOME USER ASK
  static const String fileType = 'ما نوع هذا الملف؟';
  static const String rays = 'اشعه';
  static const String analysis = 'تحاليل';

  // ERROR MESSAGES
  static const String networkError = 'خطأ في الاتصال بالشبكة';
  static const String serverError = 'خطأ في الخادم';
  static const String unknownError = 'حدث خطأ غير معروف';
  static const String uploadFailed = 'فشل في رفع الملف';

  // bottom Navigation Bar
  static const String home = 'الرئيسية';
  static const String file = 'الملفات';
  static const String profile = 'الملف الشخصي';

  // API ERROR MESSAGES
  static const String connectionTimeoutError =
      'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى';
  static const String sendTimeoutError =
      'انتهت مهلة الإرسال. يرجى المحاولة مرة أخرى';
  static const String receiveTimeoutError =
      'انتهت مهلة الاستقبال. يرجى المحاولة مرة أخرى';
  static const String badCertificateError = 'شهادة الأمان غير صحيحة';
  static const String cancelledRequestError = 'تم إلغاء الطلب';
  static const String connectionErrorMsg =
      'لا يوجد اتصال بالإنترنت. يرجى التحقق من الاتصال والمحاولة مرة أخرى';
  static const String unexpectedError =
      'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى';

  // AUTHENTICATION SUCCESS/ERROR MESSAGES
  static const String loginSuccessful = 'تم تسجيل الدخول بنجاح';
  static const String loginError = 'حدث خطأ في تسجيل الدخول، حاول مرة أخرى';
  static const String savedSuccessfully = 'تم الحفظ بنجاح';
  static const String saveFailed = 'فشل الحفظ';
  static const String saveError = 'حدث خطأ، حاول مرة أخرى';
  static const String savingInProgress = 'جاري الحفظ...';
  static const String verificationSuccessful = 'تم التحقق من الرمز بنجاح';
  static const String verificationCodeIncorrect =
      'رمز التحقق غير صحيح، حاول مرة أخرى';
  static const String verificationCodeResent =
      'تم إعادة إرسال رمز التحقق بنجاح';
  static const String resendCodeFailed =
      'فشل في إعادة إرسال الرمز. يرجى المحاولة مرة أخرى.';
  static const String sending = 'جاري الإرسال...';
  static const String passwordChangeSuccessful = 'تم تغيير كلمة المرور بنجاح';
  static const String passwordChangeError =
      'حدث خطأ في تغيير كلمة المرور، حاول مرة أخرى';
  static const String verificationCodeSentSuccessfully =
      'تم إرسال رمز التحقق بنجاح';
  static const String forgotPasswordError = 'حدث خطأ غير متوقع، حاول مرة أخرى';
  static const String loginFailed = 'فشل تسجيل الدخول';

  // PROFILE RELATED STRINGS
  static const String bloodTypeLabel = ' فصيلة الدم: ';
  static const String heightLabel = ' الطول: ';
  static const String weightLabel = ' الوزن: ';

  // FILE UPLOAD ERROR MESSAGES
  static const String fileSizeError = 'الملفات يجب ألا تتعدى 25 ميجا';
  static const String filePathError = 'مسار الملف غير صحيح';
  static const String uploadFailedUnexpectedResponse =
      'فشل في رفع الملف: استجابة غير متوقعة';
  static const String uploadFailedNoResponse =
      'فشل في رفع الملف: لا توجد استجابة';
  static const String uploadFailedGeneral = 'فشل في رفع الملف: ';
  static const String uploadingFile = 'جاري رفع: ';

  // MEDICAL DOCUMENT ANALYSIS
  static const String dataLoadError = 'خطأ في تحميل البيانات: ';
  static const String analyzeMedicalDocument = 'تحليل المستند الطبي';
  static const String analyzingMedicalDocument = 'جاري تحليل المستند الطبي...';
  static const String analysisError = 'حدث خطأ أثناء تحليل المستند';
  static const String pleaseRetry = 'يرجى المحاولة مرة أخرى';
  static const String retryLabel = 'إعادة المحاولة';
  static const String noMedicalDataToShow = 'لا توجد بيانات طبية للعرض';
  static const String noExtractableInfo =
      'المستند لا يحتوي على معلومات طبية قابلة للاستخراج';
  static const String patientInfo = 'معلومات المريض';
  static const String unspecifiedPatient = 'مريض غير محدد';
  static const String genderLabel = 'الجنس: ';
  static const String prescribedMedications = 'الأدوية المصروفة';
  static const String unspecifiedMedication = 'دواء غير محدد';
  static const String unspecifiedDosage = 'الجرعة غير محددة';
  static const String unspecified = 'غير محدد';

  // GOOGLE DRIVE FILE PICKER
  static const String googleDriveLoginFailed =
      'فشل تسجيل الدخول في Google Drive';
  static const String selectFilesFromGoogleDrive = 'اختر ملفات من Google Drive';
  static const String noFilesToShow = 'لا توجد ملفات للعرض';
  static const String noName = 'بدون اسم';
  static const String filesSelected = 'تم اختيار \${count} ملف';
  static const String addFiles = 'إضافة الملفات';
  static const String analyzeFile = 'تحليل الملف الطبي';

  // EMERGENCY CONTACTS
  static const String noEmergencyContacts = 'لا توجد جهات طوارئ';
  static const String emergencyContactDetails = 'تفاصيل جهة الطوارئ';
  static const String nameLabel = 'الاسم: ';
  static const String phoneLabel = 'رقم الهاتف: ';
  static const String relationLabel = 'صلة القرابة: ';
  static const String deleteEmergencyContact = 'حذف جهة الطوارئ';
  static const String errorOccurred = 'حدث خطأ';

  // VALIDATION AND INPUT ERRORS
  static const String pleaseEnterVerificationCode =
      'من فضلك أدخل رمز التحقق بالكامل';
  static const String unexpectedErrorRetry =
      'حدث خطأ غير متوقع. الرجاء المحاولة مرة أخرى';
  static const String invalidUserRole =
      'دور المستخدم غير صالح. يرجى المحاولة مرة أخرى.';
  static const String registrationError = 'حدث خطأ أثناء التسجيل: ';
  static const String enterPhoneNumber = 'أدخل رقم هاتفك';
  static const String imageSelectedSuccessfully = 'تم اختيار الصورة بنجاح';
  static const String changeImage = 'تغيير الصورة';
  static const String maleGender = 'ذكر';
  static const String femaleGender = 'أنثى';
  static const String pleaseUploadPersonalPhoto = 'يرجى تحميل الصورة الشخصية';
  static const String pleaseUploadNationalId = 'يرجى تحميل صورة الهوية';
  static const String passwordsDoNotMatchError = 'كلمتا المرور غير متطابقتين';
  static const String pleaseEnterEmail = 'من فضلك أدخل البريد الإلكتروني';
  static const String pleaseEnterEmailAndPassword =
      'من فضلك أدخل البريد وكلمة المرور';

  // DOCUMENT VIEW STRINGS
  static const String documentDetails = 'تفاصيل المستند';
  static const String unspecifiedDocument = 'مستند غير محدد';
  static const String fileTypeLabel = 'نوع الملف';
  static const String uploadDate = 'تاريخ الرفع';
  static const String processingDate = 'تاريخ المعالجة';
  static const String extractedMedicalData = 'البيانات الطبية المستخرجة';
  static const String extractionAccuracy = 'دقة الاستخراج: ';
  static const String patientId = 'معرف المريض';
  static const String status = 'الحالة';
  static const String active = 'نشط';
  static const String inactive = 'غير نشط';
  static const String name = 'الاسم';
  static const String reportType = 'نوع التقرير';
  static const String reportStatus = 'حالة التقرير';
  static const String summary = 'الخلاصة';
  static const String reportDate = 'تاريخ التقرير';
  static const String purpose = 'الغرض';
  static const String identifier = 'المعرف';
  static const String resourceType = 'نوع المورد';
  static const String additionalInfo = 'معلومات إضافية';
  static const String documentId = 'معرف المستند';

  // HTTP STATUS ERROR MESSAGES
  static const String badRequestError = 'يرجى التحقق من البيانات المدخلة';
  static const String unauthorizedError =
      'غير مخول للوصول. يرجى تسجيل الدخول مرة أخرى';
  static const String forbiddenError = 'ممنوع الوصول إلى هذا المورد';
  static const String notFoundError = 'المورد المطلوب غير موجود';
  static const String conflictError =
      'تعارض في البيانات. يرجى المحاولة مرة أخرى';
  static const String internalServerError =
      'خطأ داخلي في الخادم. يرجى المحاولة لاحقاً';
  static const String serviceUnavailableError =
      'الخدمة غير متاحة حالياً. يرجى المحاولة لاحقاً';

  // COMMON FIELD VALIDATION ERRORS (Arabic translations for common API validation messages)
  static const String emailInvalidError = 'البريد الإلكتروني غير صحيح';
  static const String passwordRequiredError = 'كلمة المرور مطلوبة';
  static const String phoneInvalidError = 'رقم الهاتف غير صحيح';
  static const String accountExistsError =
      'يوجد حساب مرتبط بهذا البريد الإلكتروني بالفعل';
  static const String accountNotFoundError =
      'لم يتم العثور على حساب بهذا البريد الإلكتروني';
  static const String invalidCredentialsError =
      'البريد الإلكتروني أو كلمة المرور غير صحيحة';
  static const String accountNotVerifiedError =
      'الحساب غير مفعل. يرجى التحقق من بريدك الإلكتروني';
  static const String verificationCodeInvalidError = 'رمز التحقق غير صحيح';
  static const String verificationCodeExpiredError = 'انتهت صلاحية رمز التحقق';
  static const String uploadFailedRetry =
      'فشل في رفع الملف. يرجى المحاولة مرة أخرى';
  static const String fileSizeExceededError =
      'حجم الملف كبير جداً. الحد الأقصى 25 ميجابايت';
  static const String fileTypeNotSupportedError =
      'نوع الملف غير مدعوم. يرجى استخدام صور بصيغة JPEG أو PNG';
}
