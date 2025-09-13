import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import '../../data/models/file_upload_service.dart';
import 'file_preview.dart';
import 'file_type_dialog.dart';

class UploadFileCard extends ConsumerWidget {
  const UploadFileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.sizeOf(context).height * 0.3,
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
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.15,
            width: double.infinity,
            child: DottedBorder(
              strokeWidth: 1.5,
              borderType: BorderType.RRect,
              child: Center(child: const FilePreview()),
            ),
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
                  onPressed: () {},
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
    );
  }
}
