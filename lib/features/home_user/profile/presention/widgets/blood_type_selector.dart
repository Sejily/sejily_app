import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';

class BloodTypeSelector extends StatelessWidget {
  final String? selected;
  final Function(String?) onChanged;

  const BloodTypeSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 12,
      children: AppStrings.bloodTypes.map((type) {
        return SizedBox(
          width: (MediaQuery.of(context).size.width - 16 * 2 - 20) / 2,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<String>(
                value: type,
                groupValue: selected,
                activeColor: Colors.blue,
                onChanged: onChanged,
              ),
              Text(type, style: AppTextStyles.regular14),
            ],
          ),
        );
      }).toList(),
    );
  }
}
