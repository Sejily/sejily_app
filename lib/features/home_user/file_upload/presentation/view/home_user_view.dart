import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';
import '../../../profile/presention/manager/providers/user_provider.dart';
import '../widgets/upload_file_card.dart';

class UploadFilePage extends ConsumerWidget {
  const UploadFilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProfileProvider);

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
                    userAsync.when(
                      data: (result) {
                        return result.when(
                          onSuccess: (user) => Row(
                            children: [
                              Text(
                                "${AppStrings.welcome} ${user.name}",
                                style: AppTextStyles.medium16.copyWith(
                                  color: AppColors.jetBlack,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text("👋", style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          onFailure: (_) => Text(
                            "${AppStrings.welcome} ",
                            style: AppTextStyles.medium16.copyWith(
                              color: AppColors.jetBlack,
                            ),
                          ),
                        );
                      },
                      loading: () => const CircularProgressIndicator(),
                      error: (_, __) => Text(
                        "${AppStrings.welcome} ",
                        style: AppTextStyles.medium16.copyWith(
                          color: AppColors.jetBlack,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.notifications_outlined, size: 26),
                        const SizedBox(width: 12),
                        userAsync.when(
                          data: (result) {
                            return result.when(
                              onSuccess: (user) => CircleAvatar(
                                radius: 20,
                                backgroundImage: user.avatarUrl != null
                                    ? NetworkImage(user.avatarUrl!)
                                    : const AssetImage(
                                            "assets/images/selected_person.png",
                                          )
                                          as ImageProvider,
                              ),
                              onFailure: (_) => const CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                  "assets/images/selected_person.png",
                                ),
                              ),
                            );
                          },
                          loading: () => const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                              "assets/images/selected_person.png",
                            ),
                          ),
                          error: (_, __) => const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                              "assets/images/selected_person.png",
                            ),
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
                  border: Border.all(color: const Color(0xFFFFD54F)),
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
