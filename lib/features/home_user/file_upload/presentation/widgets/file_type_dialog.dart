import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';

class FileTypeDialog extends StatelessWidget {
  final Function(String type) onPick;

  const FileTypeDialog({super.key, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.fileType,
              style: AppTextStyles.bold20.copyWith(color: AppColors.darkBlue),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _DialogueOption(
                  onPick: (type) => onPick(AppStrings.rays),
                  tite: AppStrings.rays,
                ),
                const SizedBox(width: 12),
                _DialogueOption(
                  onPick: (type) => onPick(AppStrings.analysis),
                  tite: AppStrings.analysis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogueOption extends StatelessWidget {
  const _DialogueOption({required this.tite, required this.onPick});

  final String tite;
  final Function(String type) onPick;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          onPick(tite);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkBlue,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          tite,
          style: AppTextStyles.medium16.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
