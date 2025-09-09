import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/widgets/build_field_with_label.dart';
import 'package:sejily/core/widgets/custom_app_bar.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/features/authentication/presentation/manager/providers/auth_provider.dart';
import 'package:sejily/features/authentication/presentation/manager/providers/progress_provider.dart';
import 'package:sejily/features/authentication/presentation/widgets/image_upload_section.dart';
import 'package:sejily/features/authentication/presentation/widgets/step_progress_bar.dart';
import 'dart:io';

class UploadPersonalPhotoPage extends ConsumerStatefulWidget {
  const UploadPersonalPhotoPage({super.key});

  @override
  ConsumerState<UploadPersonalPhotoPage> createState() =>
      _UploadPersonalPhotoPageState();
}

class _UploadPersonalPhotoPageState
    extends ConsumerState<UploadPersonalPhotoPage> {
  File? _selectedProfilePicture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(progressProvider.notifier)
          .updateProgressForRoute(Routes.uploadPersonalPhoto);
    });
  }

  void _showError(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.lightRed),
    );
  }

  void _onContinue() async {
    if (_selectedProfilePicture == null) {
      _showError('يرجى تحميل الصورة الشخصية');
      return;
    }

    // Update registration data
    await ref
        .read(authNotifierProvider.notifier)
        .updateUserData(profilePicture: _selectedProfilePicture);

    // Check user role to determine next navigation
    final authNotifier = ref.read(authNotifierProvider.notifier);
    final isDoctor = await authNotifier.isDoctor();

    ref.read(progressProvider.notifier).nextStep();

    if (mounted) {
      if (isDoctor) {
        context.push(Routes.uploadHospitalAffiliation);
      } else {
        context.push(Routes.emergencyContact);
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: const StepProgressBar(),
                  ),
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

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildFieldWithLabel(
                          label: AppStrings.personalPicture,
                          required: true,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.uploadPersonalPictureDescription,
                                style: AppTextStyles.regular14.copyWith(
                                  color: AppColors.gray,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ImageUploadSection(
                                selectedImage: _selectedProfilePicture,
                                onImageSelected: (image) => setState(() {
                                  _selectedProfilePicture = image;
                                }),
                                onError: _showError,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  CustomButton(onPressed: _onContinue, text: AppStrings.next),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    ); // Closing for PopScope
  }
}
