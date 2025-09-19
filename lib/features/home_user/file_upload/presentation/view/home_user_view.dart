import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sejily/core/utils/app_assets.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/widgets/action_button.dart';
import 'package:sejily/features/home_user/file_upload/data/models/file_upload_service.dart';
import 'package:sejily/features/home_user/file_upload/presentation/widgets/drive_file_picker_dialog.dart';
import 'package:sejily/features/home_user/file_upload/presentation/widgets/file_preview.dart';
import 'package:sejily/features/home_user/file_upload/presentation/widgets/file_type_dialog.dart';
import 'package:sejily/features/home_user/file_upload/presentation/widgets/user_app_bar.dart';
import 'package:sejily/features/home_user/profile/presention/widgets/warning_card.dart';

class UploadFilePage extends ConsumerWidget {
  const UploadFilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UserAppBar(),
              WarningCard(
                textColor: AppColors.brown,
                bgColor: AppColors.lightOrange,
                borderColor: AppColors.orange,
                description: AppStrings.warningDescription,
              ),

              const UploadFileCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadFileCard extends ConsumerWidget {
  const UploadFileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
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
            height: MediaQuery.sizeOf(context).height * 0.2,
            width: double.infinity,
            child: DottedBorder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              dashPattern: [15, 20],
              stackFit: StackFit.expand,
              strokeWidth: 1.5,
              radius: Radius.circular(16),
              borderType: BorderType.RRect,
              child: FilePreview(),
            ),
          ),

          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ActionButton(
                  text: AppStrings.browse,
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => FileTypeDialog(
                      onPick: (type) =>
                          FileUploadService.pickFiles(context, ref, type),
                    ),
                  ),
                  icon: SvgPicture.asset(Assets.fileUpload, height: 24),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ActionButton(
                  text: "Drive",
                  icon: Image.asset(Assets.drive, height: 24),
                  isOutlined: true,
                  textColor: AppColors.black,
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => DriveFilePickerDialog(ref: ref),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
