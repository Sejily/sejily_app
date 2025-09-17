import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/widgets/custom_app_bar.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/features/authentication/presentation/manager/providers/register_provider.dart';
import 'package:sejily/features/authentication/presentation/manager/providers/progress_provider.dart';
import 'package:sejily/features/authentication/presentation/widgets/image_upload_section.dart';
import 'package:sejily/features/authentication/presentation/widgets/nationality_and_national_id_section.dart';
import 'dart:io';

import 'package:sejily/features/authentication/presentation/widgets/step_progress_bar.dart';

class UploadNationalIdPage extends ConsumerStatefulWidget {
  const UploadNationalIdPage({super.key});

  @override
  ConsumerState<UploadNationalIdPage> createState() =>
      _UploadNationalIdPageState();
}

class _UploadNationalIdPageState extends ConsumerState<UploadNationalIdPage> {
  final _formKey = GlobalKey<FormState>();
  final _nationalIdController = TextEditingController();

  String _selectedNationality = 'مصري';
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(progressProvider.notifier)
          .updateProgressForRoute(Routes.uploadNationalId);
    });
  }

  @override
  void dispose() {
    _nationalIdController.dispose();
    super.dispose();
  }

  void _onSubmit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_selectedImage == null) {
      _showError('يرجى تحميل صورة الهوية');
      return;
    }

    // Update registration data
    await ref
        .read(registerNotifierProvider.notifier)
        .updateUserData(
          nationality: _selectedNationality,
          nationalId: _nationalIdController.text,
          idPicture: _selectedImage,
        );

    ref.read(progressProvider.notifier).nextStep();

    if (mounted) {
      context.push(Routes.uploadPersonalPhoto);
    }
  }

  void _showError(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.lightRed),
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
                    _buildHeader(),
                    _buildFormFields(),
                    CustomButton(onPressed: _onSubmit, text: AppStrings.next),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ); // Closing for PopScope
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.completePersonalProfile,
          style: AppTextStyles.bold24.copyWith(color: AppColors.jetBlack),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.helpUsProvidePersonalizedExperience,
          style: AppTextStyles.regular14.copyWith(
            color: AppColors.grayShade500,
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NationalityAndNationalIdSection(
            selectedNationality: _selectedNationality,
            onNationalityChanged: (nationality) =>
                setState(() => _selectedNationality = nationality),
            nationalIdController: _nationalIdController,
          ),
          const SizedBox(height: 20),
          ImageUploadSection(
            selectedImage: _selectedImage,
            onImageSelected: (image) => setState(() => _selectedImage = image),
            onError: _showError,
          ),
        ],
      ),
    );
  }
}
