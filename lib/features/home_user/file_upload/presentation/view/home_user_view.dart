import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/features/home_user/file_upload/presentation/widgets/user_app_bar.dart';
import '../widgets/upload_file_card.dart';

class UploadFilePage extends ConsumerWidget {
  const UploadFilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [UserAppBar(), _warningCard()]),

              const UploadFileCard(),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Container _warningCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        border: const Border(right: BorderSide(color: Colors.orange)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info, color: Colors.orange),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.warning,
                  style: AppTextStyles.semiBold18.copyWith(color: Colors.brown),
                ),
                Text(
                  AppStrings.warningDescription,
                  style: AppTextStyles.regular14.copyWith(color: Colors.brown),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
