import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/newtorking/api_result.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/utils/app_assets.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/features/home_user/profile/data/models/user_model.dart';
import 'package:sejily/features/home_user/profile/presention/manager/providers/user_provider.dart';

class UserAppBar extends ConsumerWidget {
  const UserAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProfileProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        userAsync.when(
          data: (result) {
            return result.when(
              onSuccess: (user) => Row(
                children: [
                  _userProfilePicture(userAsync, context),
                  const SizedBox(width: 8),
                  Text(
                    "${AppStrings.welcome} ${user.name.split(' ').first} ",
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
            style: AppTextStyles.medium16.copyWith(color: AppColors.jetBlack),
          ),
        ),
        SvgPicture.asset(Assets.notificationIcon, height: 26),
      ],
    );
  }

  Widget _userProfilePicture(
    AsyncValue<ApiResult<UserModel>> userAsync,
    BuildContext context,
  ) {
    return userAsync.when(
      data: (result) {
        return result.when(
          onSuccess: (user) => GestureDetector(
            onTap: () => context.go(Routes.profile),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: user.avatarUrl != null
                  ? NetworkImage(user.avatarUrl!)
                  : const AssetImage(Assets.selectedPerson),
            ),
          ),
          onFailure: (_) => _PlaceHolder(),
        );
      },
      loading: () => const _PlaceHolder(),
      error: (_, __) => const _PlaceHolder(),
    );
  }
}

class _PlaceHolder extends StatelessWidget {
  const _PlaceHolder();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 20,
      backgroundImage: AssetImage(Assets.selectedPerson),
    );
  }
}
