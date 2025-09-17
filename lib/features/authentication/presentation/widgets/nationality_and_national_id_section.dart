import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/services.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_validators.dart';
import 'package:sejily/core/widgets/build_field_with_label.dart';

class NationalityAndNationalIdSection extends StatelessWidget {
  const NationalityAndNationalIdSection({
    super.key,
    required this.selectedNationality,
    required this.onNationalityChanged,
    required this.nationalIdController,
  });

  final String selectedNationality;
  final ValueChanged<String> onNationalityChanged;
  final TextEditingController nationalIdController;

  static const int _nationalIdLength = 14;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _selectNationalityField(),
        const SizedBox(height: 20),
        _selectNationalityIdField(),
      ],
    );
  }

  BuildFieldWithLabel _selectNationalityIdField() {
    return BuildFieldWithLabel(
      label: AppStrings.nationalIdNumber,
      required: true,
      child: TextFormField(
        controller: nationalIdController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(_nationalIdLength),
        ],
        style: AppTextStyles.medium16.copyWith(color: AppColors.black),
        decoration: _buildInputDecoration(),
        validator: AppValidators.nationalIdWithLengthValidator,
      ),
    );
  }

  BuildFieldWithLabel _selectNationalityField() {
    return BuildFieldWithLabel(
      label: AppStrings.nationality,
      required: true,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGray),
          borderRadius: BorderRadius.circular(16),
        ),
        child: CountryCodePicker(
          onChanged: (country) => onNationalityChanged(country.name ?? 'مصري'),
          initialSelection: 'EG',
          favorite: const ['EG', 'SA', 'AE'],
          showCountryOnly: true,
          showOnlyCountryWhenClosed: true,
          padding: EdgeInsetsGeometry.zero,
          alignLeft: true,
          textStyle: AppTextStyles.medium16.copyWith(color: AppColors.black),
          flagDecoration: BoxDecoration(shape: BoxShape.circle),
          flagWidth: 40,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      border: _buildBorder(AppColors.lightGray),
      enabledBorder: _buildBorder(AppColors.lightGray),
      focusedBorder: _buildBorder(AppColors.darkBlue),
      errorBorder: _buildBorder(AppColors.lightRed),
      hintText: '12345678901234',
      hintStyle: AppTextStyles.regular16.copyWith(
        color: AppColors.grayShade500,
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color),
    );
  }
}
