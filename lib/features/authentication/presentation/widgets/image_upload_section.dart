import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sejily/core/utils/app_assets.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'dart:io';

class ImageUploadSection extends StatelessWidget {
  const ImageUploadSection({
    super.key,
    required this.selectedImage,
    required this.onImageSelected,
    required this.onError,
    this.isNationalIdPic,
  });

  final File? selectedImage;
  final ValueChanged<File?> onImageSelected;
  final ValueChanged<String> onError;
  final bool? isNationalIdPic;

  static final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(8),
      dashPattern: const [8, 4],
      color: AppColors.darkBlue,
      strokeWidth: 2,
      child: _buildUploadContainer(),
    );
  }

  Widget _buildUploadContainer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.skyBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: selectedImage != null
            ? _buildSelectedImageView()
            : _buildUploadPrompt(),
      ),
    );
  }

  List<Widget> _buildSelectedImageView() {
    return [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: FileImage(selectedImage!),
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(height: 12),
      Text(
        'تم اختيار الصورة بنجاح',
        style: AppTextStyles.medium14.copyWith(color: AppColors.darkBlue),
      ),
      const SizedBox(height: 8),
      GestureDetector(
        onTap: _pickImage,
        child: Text(
          'تغيير الصورة',
          style: AppTextStyles.medium14.copyWith(
            color: AppColors.darkBlue,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildUploadPrompt() {
    return [
      SizedBox(height: 48, child: Image.asset(Assets.upload)),
      const SizedBox(height: 16),
      Text(
        AppStrings.dragDropOrTapToUpload,
        style: AppTextStyles.medium16.copyWith(color: AppColors.jetBlack),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 8),
      Text(
        isNationalIdPic ?? false
            ? AppStrings.imageUploadNationalId
            : AppStrings.imageUploadCriteria,
        style: AppTextStyles.regular12.copyWith(color: AppColors.grayShade500),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 16),
      _buildBrowseButton(),
    ];
  }

  Widget _buildBrowseButton() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.darkBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          AppStrings.browseFiles,
          style: AppTextStyles.medium14.copyWith(color: AppColors.white),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null) {
        onImageSelected(File(image.path));
      }
    } catch (e) {
      onError(AppStrings.uploadFailed);
    }
  }
}
