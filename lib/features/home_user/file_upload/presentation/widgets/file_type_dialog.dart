import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/widgets/action_button.dart';

class FileTypeDialog extends StatelessWidget {
  final Function(String type) onPick;

  const FileTypeDialog({super.key, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.fileType,
              style: AppTextStyles.semiBold16.copyWith(
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onPick(AppStrings.rays);
                    },
                    text: AppStrings.rays,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onPick(AppStrings.analysis);
                    },
                    text: AppStrings.analysis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
