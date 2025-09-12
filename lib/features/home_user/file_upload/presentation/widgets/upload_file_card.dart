import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import '../../data/models/file_upload_service.dart';
import '../manager/providers/file_upload_provider.dart';
import 'drive_file_picker_dialog.dart';
import 'file_preview.dart';
import 'file_type_dialog.dart';

class UploadFileCard extends ConsumerWidget {
  const UploadFileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFiles = ref.watch(fileUploadProvider);

    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.lightGray),
          ),
          child: Column(
            children: [
              Text(
                AppStrings.uploadFile,
                style: AppTextStyles.bold20.copyWith(color: AppColors.jetBlack),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.gray, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: FilePreview(files: selectedFiles),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: AppStrings.browse,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => FileTypeDialog(
                            onPick: (type) {
                              FileUploadService.pickFiles(context, ref, type);
                            },
                          ),
                        );
                      },
                      backgroundColor: AppColors.darkBlue,
                      foregroundColor: AppColors.white,
                      defaultSize: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.upload, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            AppStrings.browse,
                            style: AppTextStyles.regular14.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => DriveFilePickerDialog(ref: ref),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: Image.asset("assets/images/drive.png", height: 20),
                      label: Text("Drive", style: AppTextStyles.regular14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
