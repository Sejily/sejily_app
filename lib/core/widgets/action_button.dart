import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.textColor = AppColors.black,
    this.borderColor = AppColors.grayShade400,
    this.isOutlined = false,
    this.defaultSize = false,
  });

  final VoidCallback? onPressed;
  final String text;
  final Widget? icon;
  final bool isOutlined;
  final Color textColor;
  final Color borderColor;
  final bool defaultSize;

  @override
  Widget build(BuildContext context) {
    final buttonChild = icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon!,
              SizedBox(width: 8),
              Text(text, style: AppTextStyles.semiBold16),
            ],
          )
        : Text(text, style: AppTextStyles.semiBold16);

    final buttonStyle = ButtonStyle(
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.015,
        ),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      foregroundColor: WidgetStateProperty.all(
        isOutlined ? textColor : AppColors.white,
      ),
      backgroundColor: WidgetStateProperty.all(
        isOutlined ? Colors.transparent : AppColors.darkBlue,
      ),
      side: isOutlined
          ? WidgetStateProperty.all(BorderSide(color: borderColor))
          : null,
    );

    return isOutlined
        ? OutlinedButton(
            onPressed: onPressed,
            style: buttonStyle,
            child: buttonChild,
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: buttonStyle,
            child: buttonChild,
          );
  }
}
