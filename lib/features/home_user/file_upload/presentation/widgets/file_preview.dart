import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:sejily/core/utils/app_assets.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/features/home_user/file_upload/presentation/widgets/fhir_search_dialog.dart';
import '../manager/providers/file_upload_provider.dart';

class FilePreview extends ConsumerWidget {
  const FilePreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileUploadState = ref.watch(fileUploadProvider);

    // Listen for errors and show snackbar
    ref.listen(fileUploadProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'حسناً',
              textColor: Colors.white,
              onPressed: () =>
                  ref.read(fileUploadProvider.notifier).clearError(),
            ),
          ),
        );
      }
    });

    // Show loading state when uploading
    if (fileUploadState.isUploading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 12),
          Text(
            'جاري رفع: ${fileUploadState.currentUploadingFile}',
            style: AppTextStyles.medium14.copyWith(color: AppColors.gray),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    if (fileUploadState.files.isEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(Assets.clipboard, height: 50),
          Column(
            children: [
              Text(
                AppStrings.dragDropOrTapToUpload,
                style: AppTextStyles.medium16,
              ),
              Text(
                AppStrings.uploadfileDescription,
                textAlign: TextAlign.center,
                style: AppTextStyles.regular12.copyWith(color: AppColors.gray),
              ),
            ],
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ListView.builder(
        itemCount: fileUploadState.files.length,
        itemBuilder: (context, index) {
          final uploadedFile = fileUploadState.files[index];
          final file = uploadedFile.platformFile;
          return GestureDetector(
            onTap: () async =>
                await OpenFile.open(uploadedFile.platformFile.path!),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 8),
                    Icon(
                      Icons.insert_drive_file,
                      size: 30,
                      color: AppColors.gray,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          file.name,
                          style: AppTextStyles.medium16.copyWith(
                            color: AppColors.jetBlack,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${(file.size / 1024).toStringAsFixed(2)} KB",
                          style: AppTextStyles.regular12.copyWith(
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () =>
                          _showFhirDialog(context, ref, uploadedFile),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        backgroundColor: AppColors.darkBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: AppColors.darkBlue),
                        ),
                      ),
                      child: Text(
                        'تحليل الملف الطبي',
                        style: AppTextStyles.regular12.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => ref
                          .read(fileUploadProvider.notifier)
                          .removeFile(file),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showFhirDialog(
    BuildContext context,
    WidgetRef ref,
    UploadedFile uploadedFile,
  ) {
    showDialog(
      context: context,
      builder: (context) => FhirSearchDialog(fileId: uploadedFile.fileId),
    );
  }
}
