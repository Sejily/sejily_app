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
import 'package:sejily/features/authentication/presentation/widgets/image_upload_section.dart';
import 'package:sejily/features/authentication/presentation/manager/providers/progress_provider.dart';
import 'package:sejily/features/authentication/presentation/manager/providers/registration_provider.dart';
import 'package:sejily/features/authentication/presentation/widgets/step_progress_bar.dart';
import 'dart:io';

class UploadMedicalLicensePage extends ConsumerStatefulWidget {
  const UploadMedicalLicensePage({super.key});

  @override
  ConsumerState<UploadMedicalLicensePage> createState() =>
      _UploadMedicalLicensePageState();
}

class _UploadMedicalLicensePageState
    extends ConsumerState<UploadMedicalLicensePage> {
  final formKey = GlobalKey<FormState>();
  final medicalLicenseNumberController = TextEditingController();
  File? _selectedMedicalLicenseImage;

  @override
  void initState() {
    super.initState();
    // Ensure we're on step 5 (final step) when this page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(progressProvider.notifier)
          .updateProgressForRoute(Routes.uploadMedicalLicense);
    });
  }

  @override
  void dispose() {
    medicalLicenseNumberController.dispose();
    super.dispose();
  }

  void _onContinuePressed() {
    if (formKey.currentState?.validate() == true) {
      // Save medical license data to registration provider
      ref
          .read(doctorRegistrationProvider.notifier)
          .update(
            (state) => state.copyWith(
              licenseNumber: medicalLicenseNumberController.text.trim(),
              licensePicture: _selectedMedicalLicenseImage,
            ),
          );

      //TODO: Register Doctor logic

      // Move to final step with smooth animation
      ref.read(progressProvider.notifier).nextStep();
      context.go(Routes.dataReview);
    }
  }

  void _onImageSelected(File? file) {
    setState(() {
      _selectedMedicalLicenseImage = file;
    });
  }

  void _onImageError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error), backgroundColor: AppColors.lightRed),
    );
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
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

                // Form
                Expanded(
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: BuildFieldWithLabel(
                              label: AppStrings.medicalLicenseNumber,
                              required: true,
                              child: CustomTextField(
                                controller: medicalLicenseNumberController,
                                validator: AppValidators.requiredFieldValidator,
                              ),
                            ),
                          ),

                          // Medical License Document Upload
                          BuildFieldWithLabel(
                            required: true,
                            label: AppStrings.medicalLicenseDocument,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.uploadPersonalPictureDescription,
                                ),
                                const SizedBox(height: 12),
                                ImageUploadSection(
                                  selectedImage: _selectedMedicalLicenseImage,
                                  onImageSelected: _onImageSelected,
                                  onError: _onImageError,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),

                          CustomButton(
                            text: AppStrings.finish,
                            onPressed: _onContinuePressed,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ); // Closing for PopScope
  }
}
