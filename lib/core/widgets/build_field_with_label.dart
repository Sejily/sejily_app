import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';

class BuildFieldWithLabel extends StatefulWidget {
  const BuildFieldWithLabel({
    super.key,
    required this.label,
    required this.child,
    this.required,
  });
  final String label;
  final Widget child;
  final bool? required;

  @override
  State<BuildFieldWithLabel> createState() => _BuildFieldWithLabelState();
}

class _BuildFieldWithLabelState extends State<BuildFieldWithLabel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            children: [
              Text(widget.label, style: AppTextStyles.semiBold18),
              widget.required ?? false
                  ? Text(
                      '*',
                      style: AppTextStyles.semiBold18.copyWith(
                        color: AppColors.lightRed,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        const SizedBox(height: 8),
        widget.child,
      ],
    );
  }
}
