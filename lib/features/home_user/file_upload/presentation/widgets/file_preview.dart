import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';
import '../manager/providers/file_upload_provider.dart';

class FilePreview extends ConsumerWidget {
  final List<PlatformFile> files;

  const FilePreview({super.key, required this.files});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (files.isEmpty) {
      return Column(
        children: [
          Icon(Icons.folder, size: 50, color: AppColors.darkBlue),
          const SizedBox(height: 12),
          Text(AppStrings.dragDropOrTapToUpload, style: AppTextStyles.medium16),
          const SizedBox(height: 8),
          Text(
            AppStrings.uploadfileDescription,
            textAlign: TextAlign.center,
            style: AppTextStyles.regular12.copyWith(color: AppColors.gray),
          ),
        ],
      );
    }

    return Column(
      children: files.map((file) {
        return ListTile(
          leading: Icon(
            Icons.insert_drive_file,
            size: 30,
            color: AppColors.gray,
          ),
          title: Text(
            file.name,
            style: AppTextStyles.medium16.copyWith(color: AppColors.jetBlack),
          ),
          subtitle: Text(
            "${(file.size / 1024).toStringAsFixed(2)} KB",
            style: AppTextStyles.regular12.copyWith(color: AppColors.gray),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () =>
                ref.read(fileUploadProvider.notifier).removeFile(file),
          ),
          onTap: () => OpenFile.open(file.path),
        );
      }).toList(),
    );
  }
}
