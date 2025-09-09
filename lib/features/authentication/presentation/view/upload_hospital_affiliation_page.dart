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
import 'package:sejily/features/authentication/presentation/manager/providers/auth_provider.dart';
import 'package:sejily/features/authentication/presentation/manager/providers/progress_provider.dart';
import 'package:sejily/features/authentication/presentation/widgets/custom_dropdown_form_field.dart';
import 'package:sejily/features/authentication/presentation/widgets/step_progress_bar.dart';

class UploadHospitalAffiliationPage extends ConsumerStatefulWidget {
  const UploadHospitalAffiliationPage({super.key});

  @override
  ConsumerState<UploadHospitalAffiliationPage> createState() =>
      _UploadHospitalAffiliationPageState();
}

class _UploadHospitalAffiliationPageState
    extends ConsumerState<UploadHospitalAffiliationPage> {
  final _formKey = GlobalKey<FormState>();
  final _hospitalNameController = TextEditingController();
  final _cityController = TextEditingController();

  String? _selectedSpecialization;

  @override
  void initState() {
    super.initState();
    // Ensure we're on step 4 when this page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(progressProvider.notifier)
          .updateProgressForRoute(Routes.uploadHospitalAffiliation);
    });
  }

  @override
  void dispose() {
    _hospitalNameController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _onNext() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedSpecialization == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppStrings.fieldRequired),
            backgroundColor: AppColors.lightRed,
          ),
        );
        return;
      }
      // Update registration data using centralized method
      await ref
          .read(authNotifierProvider.notifier)
          .updateUserData(
            hospitalAffiliation: _hospitalNameController.text.trim(),
            city: _cityController.text.trim(),
            specialization: _selectedSpecialization!,
          );

      // Move to next step with smooth animation
      ref.read(progressProvider.notifier).nextStep();

      if (mounted) {
        context.push(Routes.uploadMedicalLicense);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          ref.read(progressProvider.notifier).previousStep();
        }
      },
      child: Scaffold(
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
                    const SizedBox(height: 17),
                    const StepProgressBar(),
                    const SizedBox(height: 17),
                    Text(
                      AppStrings.completeProfessionalProfile,
                      style: AppTextStyles.bold24.copyWith(
                        color: AppColors.jetBlack,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.addProfessionalInfoDescription,
                      style: AppTextStyles.regular14.copyWith(
                        color: AppColors.gray,
                      ),
                    ),
                    _buildFormFields(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: CustomButton(
                        onPressed: _onNext,
                        text: AppStrings.next,
                      ),
                    ),
                  ],
                ),
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
          // Hospital Name Field
          BuildFieldWithLabel(
            label: AppStrings.hospitalName,
            child: CustomTextField(
              controller: _hospitalNameController,
              validator: AppValidators.requiredFieldValidator,
            ),
          ),
          const SizedBox(height: 20),

          // City Field
          BuildFieldWithLabel(
            label: AppStrings.city,
            required: true,
            child: CustomTextField(
              controller: _cityController,
              validator: AppValidators.requiredFieldValidator,
            ),
          ),
          const SizedBox(height: 20),

          // Specialization Dropdown Field
          BuildFieldWithLabel(
            label: AppStrings.specialization,
            required: true,
            child: CustomDropdownFormField(
              value: _selectedSpecialization,
              options: AppStrings.specializationOptions,
              hintText: 'جراحة',
              onChanged: (newValue) {
                setState(() {
                  _selectedSpecialization = newValue;
                });
              },
            ),
          ),
        ],
      ),
    ); // Closing for PopScope
  }
}
