import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

    ref.listen(fileUploadProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: AppColors.red,
            action: SnackBarAction(
              label: 'حسناً',
              textColor: AppColors.white,
              onPressed: () =>
                  ref.read(fileUploadProvider.notifier).clearError(),
            ),
          ),
        );
      }
    });

    if (fileUploadState.isUploading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'جاري رفع الملف',
            style: AppTextStyles.medium14.copyWith(
              color: AppColors.grayShade500,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.2,
            child: LinearProgressIndicator(
              value: fileUploadState.uploadProgress,
              backgroundColor: AppColors.lightGray.withValues(alpha: 0.3),
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkBlue),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${(fileUploadState.uploadProgress * 100).toInt()}%',
            style: AppTextStyles.regular12.copyWith(
              color: AppColors.darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    if (fileUploadState.files.isEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Assets.clipboard, height: 50),
          const SizedBox(height: 12),
          Text(AppStrings.dragDropOrTapToUpload, style: AppTextStyles.medium16),
          const SizedBox(height: 4),
          Text(
            AppStrings.uploadfileDescription,
            textAlign: TextAlign.center,
            style: AppTextStyles.regular12.copyWith(
              color: AppColors.grayShade500,
            ),
          ),
        ],
      );
    }

    return SizedBox(
      child: ListView.builder(
        itemCount: fileUploadState.files.length,
        itemBuilder: (context, index) {
          final uploadedFile = fileUploadState.files[index];
          final file = uploadedFile.platformFile;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: GestureDetector(
              onTap: () async =>
                  await OpenFile.open(uploadedFile.platformFile.path!),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.skyBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.insert_drive_file,
                      size: 30,
                      color: AppColors.darkBlue,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
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
                          const SizedBox(height: 2),
                          Text(
                            "${(file.size / 1024).toStringAsFixed(2)} KB",
                            style: AppTextStyles.regular12.copyWith(
                              color: AppColors.grayShade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buttonSection(context, ref, uploadedFile: uploadedFile),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Row _buttonSection(
    BuildContext context,
    WidgetRef ref, {
    required UploadedFile uploadedFile,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => FhirSearchDialog(fileId: uploadedFile.fileId),
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            backgroundColor: AppColors.darkBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: AppColors.darkBlue),
            ),
          ),
          child: Text(
            'تحليل الملف الطبي',
            style: AppTextStyles.regular12.copyWith(color: AppColors.white),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => ref
              .read(fileUploadProvider.notifier)
              .removeFile(uploadedFile.platformFile),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.white,
            ),
            child: SvgPicture.asset(Assets.deleteIcon, height: 24),
          ),
        ),
      ],
    );
  }
}
