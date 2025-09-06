import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_validators.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/widgets/build_field_with_label.dart';
import 'package:sejily/core/widgets/custom_app_bar.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/core/widgets/custom_text_field.dart';
import 'package:sejily/features/authentication/presentation/manager/providers/progress_provider.dart';
import 'package:sejily/features/authentication/presentation/manager/providers/registration_provider.dart';
import 'package:sejily/features/authentication/presentation/widgets/date_picker_field.dart';
import 'package:sejily/features/authentication/presentation/widgets/phone_number_field.dart';
import 'package:sejily/features/authentication/presentation/widgets/custom_radio_button.dart';
import 'package:sejily/features/authentication/presentation/widgets/step_progress_bar.dart';

class CompleteUserDataPage extends ConsumerStatefulWidget {
  const CompleteUserDataPage({super.key});

  @override
  ConsumerState<CompleteUserDataPage> createState() =>
      _CompleteUserDataPageState();
}

class _CompleteUserDataPageState extends ConsumerState<CompleteUserDataPage> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _phoneController = TextEditingController();

  String _selectedCountryCode = '+20';
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    // Ensure we're on step 1 when this page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(progressProvider.notifier)
          .updateProgressForRoute(Routes.completeUserData);
    });
  }

  @override
  void dispose() {
    _addressController.dispose();
    _birthdateController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    await DatePickerHelper.selectDate(context, _birthdateController, (
      dateString,
    ) {
      setState(() {
        // Date is already set in the controller by the helper
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(),
                  const StepProgressBar(),
                  const SizedBox(height: 17),
                  Text(
                    AppStrings.completePersonalProfile,
                    style: AppTextStyles.bold24.copyWith(
                      color: AppColors.jetBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.helpUsProvidePersonalizedExperience,
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.gray,
                    ),
                  ),

                  _buildFormFields(),

                  CustomButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (_selectedGender == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppStrings.fieldRequired),
                              backgroundColor: AppColors.lightRed,
                            ),
                          );
                          return;
                        }

                        //* Update registration data using Riverpod
                        ref
                            .read(patientRegistrationProvider.notifier)
                            .update(
                              (state) => state.copyWith(
                                address: _addressController.text.trim(),
                                dateOfBirth: _birthdateController.text.trim(),
                                phoneNumber:
                                    '$_selectedCountryCode${_phoneController.text.trim()}',
                                gender: _selectedGender!,
                              ),
                            );
                        // Move to next step with smooth animation
                        ref.read(progressProvider.notifier).nextStep();
                        context.push(Routes.uploadNationalId);
                      }
                    },
                    text: AppStrings.next,
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Address Field
          BuildFieldWithLabel(
            label: AppStrings.address,
            child: CustomTextField(
              controller: _addressController,
              validator: AppValidators.requiredFieldValidator,
            ),
          ),
          const SizedBox(height: 20),

          // Birthdate Field
          BuildFieldWithLabel(
            label: AppStrings.dateOfBirth,
            required: true,
            child: DatePickerField(
              controller: _birthdateController,
              onTap: _selectDate,
            ),
          ),
          const SizedBox(height: 20),

          // Phone Number Field
          BuildFieldWithLabel(
            label: AppStrings.phoneNumber,
            required: true,
            child: PhoneNumberField(
              controller: _phoneController,
              initialCountryCode: _selectedCountryCode,
              onCountryCodeChanged: (countryCode) {
                setState(() {
                  _selectedCountryCode = countryCode;
                });
              },
            ),
          ),
          const SizedBox(height: 20),

          // Gender Selection
          BuildFieldWithLabel(
            label: AppStrings.gender,
            required: true,
            child: GenderRadioButtons(
              selectedGender: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
