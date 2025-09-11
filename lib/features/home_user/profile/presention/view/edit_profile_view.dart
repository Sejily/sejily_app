import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../widgets/custom_text_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomAppBar(),
                Text(
                  AppStrings.editProfile,
                  style: AppTextStyles.bold20.copyWith(
                    color: AppColors.jetBlack,
                  ),
                ),
                const SizedBox(height: 20),

                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    "assets/images/selected_person.png",
                  ),
                ),
                const SizedBox(height: 30),
                const CustomTextField(
                  label: AppStrings.fullNameLabel,
                  hint: "علي جمال",
                ),
                const SizedBox(height: 16),
                const CustomTextField(
                  label: AppStrings.emailAddress,
                  hint: "ali.gamal@email.com",
                ),
                const SizedBox(height: 16),
                const CustomTextField(
                  label: AppStrings.address,
                  hint: "حي الجامعة، المنصورة",
                ),
                const SizedBox(height: 16),
                const CustomTextField(label: AppStrings.city, hint: "المنصورة"),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    AppStrings.phoneNumber,
                    style: AppTextStyles.medium14.copyWith(
                      color: AppColors.jetBlack,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightGray),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "010695584",
                            hintStyle: AppTextStyles.regular14.copyWith(
                              color: AppColors.gray,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                CustomButton(
                  onPressed: () {},
                  text: AppStrings.save,
                  backgroundColor: AppColors.darkBlue,
                  foregroundColor: AppColors.white,
                  style: AppTextStyles.medium16.copyWith(
                    color: AppColors.white,
                  ),
                  defaultSize: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
