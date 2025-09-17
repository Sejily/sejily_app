import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_validators.dart';

class PhoneNumberField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onCountryCodeChanged;
  final String initialCountryCode;

  const PhoneNumberField({
    super.key,
    required this.controller,
    required this.onCountryCodeChanged,
    this.initialCountryCode = '+20',
  });

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  late String _selectedCountryCode;

  @override
  void initState() {
    super.initState();
    _selectedCountryCode = widget.initialCountryCode;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGray),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CountryCodePicker(
            onChanged: (country) {
              setState(() {
                _selectedCountryCode = country.dialCode!;
              });
              widget.onCountryCodeChanged(_selectedCountryCode);
            },
            initialSelection: 'EG',
            favorite: const ['+20', 'EG'],
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
            textStyle: AppTextStyles.medium16.copyWith(
              color: AppColors.jetBlack,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            flagDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Container(width: 1, height: 40, color: AppColors.lightGray),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: AppTextStyles.medium16.copyWith(color: AppColors.jetBlack),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                hintText: 'أدخل رقم هاتفك',
                hintStyle: AppTextStyles.regular16.copyWith(
                  color: AppColors.grayShade500,
                ),
              ),
              validator: AppValidators.phoneNumberValidator,
            ),
          ),
        ],
      ),
    );
  }
}
