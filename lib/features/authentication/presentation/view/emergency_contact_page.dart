import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_validators.dart';
import 'package:sejily/core/widgets/build_field_with_label.dart';
import 'package:sejily/core/widgets/custom_app_bar.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/core/widgets/custom_text_field.dart';
import 'package:sejily/features/authentication/presentation/manager/providers/registration_provider.dart';
import 'package:sejily/features/authentication/presentation/widgets/custom_dropdown_form_field.dart';
import 'package:sejily/features/authentication/presentation/widgets/phone_number_field.dart';

class EmergencyContactPage extends ConsumerStatefulWidget {
  const EmergencyContactPage({super.key});

  @override
  ConsumerState<EmergencyContactPage> createState() =>
      _EmergencyContactPageState();
}

class _EmergencyContactPageState extends ConsumerState<EmergencyContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  String _selectedCountryCode = '+20';
  String? _selectedRelationship;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onFinish() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedRelationship == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppStrings.fieldRequired),
            backgroundColor: AppColors.lightRed,
          ),
        );
        return;
      }

      // Update registration data using Riverpod
      ref
          .read(patientRegistrationProvider.notifier)
          .update(
            (state) => state.copyWith(
              emergencyContactName: _nameController.text.trim(),
              emergencyContactPhone:
                  '$_selectedCountryCode${_phoneController.text.trim()}',
              emergencyContactRelation: _selectedRelationship!,
            ),
          );

      context.go(Routes.dataReview);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const SizedBox(height: 17),
                  Text(
                    AppStrings.addEmergencyContact,
                    style: AppTextStyles.bold24.copyWith(
                      color: AppColors.jetBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.addEmergencyContactDescription,
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.gray,
                    ),
                  ),

                  _buildFormFields(),
                  const SizedBox(height: 24),

                  CustomButton(onPressed: _onFinish, text: AppStrings.finish),

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
          // Emergency Contact Name Field
          BuildFieldWithLabel(
            label: AppStrings.emergencyContactName,
            required: true,
            child: CustomTextField(
              controller: _nameController,
              validator: AppValidators.requiredFieldValidator,
            ),
          ),
          const SizedBox(height: 20),

          // Emergency Contact Phone Field
          BuildFieldWithLabel(
            label: AppStrings.emergencyContactPhone,
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

          BuildFieldWithLabel(
            label: AppStrings.relationshipToEmergencyContact,
            required: true,
            child: CustomDropdownFormField(
              value: _selectedRelationship,
              options: AppStrings.relationshipOptions,
              hintText: AppStrings.chooseRelationShip,
              onChanged: (newValue) {
                setState(() {
                  _selectedRelationship = newValue;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
