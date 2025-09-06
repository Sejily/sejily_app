import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';

class AuthenticationButton extends StatelessWidget {
  const AuthenticationButton({
    super.key,
    required this.onTap,
    required this.label,
    this.icon,
  });

  final VoidCallback onTap;
  final String label;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGray, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: icon != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(label, style: AppTextStyles.regular16),
                    const SizedBox(width: 8),
                    icon != null
                        ? SizedBox(height: 24, child: icon!)
                        : const SizedBox.shrink(),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Text(label, style: AppTextStyles.medium14),
                ),
        ),
      ),
    );
  }
}
