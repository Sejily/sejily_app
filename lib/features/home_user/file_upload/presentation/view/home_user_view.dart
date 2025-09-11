import 'package:flutter/material.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';
import '../widgets/upload_file_card.dart';

class UploadFilePage extends StatelessWidget {
  const UploadFilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${AppStrings.welcome} علي",
                          style: AppTextStyles.medium16.copyWith(
                            color: AppColors.jetBlack,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text("👋", style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(Icons.notifications_outlined, size: 26),
                        SizedBox(width: 12),
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                            "assets/images/selected_person.png",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFFFFD54F)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline, color: Colors.orange),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        AppStrings.warning,
                        style: AppTextStyles.regular14.copyWith(
                          color: Colors.brown,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const UploadFileCard(),
            ],
          ),
        ),
      ),
    );
  }
}
