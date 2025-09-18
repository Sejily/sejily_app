import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/utils/app_assets.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';
import '../routes/routes.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context: context,
            index: 0,
            icon: Assets.homeIcon,
            label: AppStrings.home,
            route: Routes.home,
          ),
          _buildNavItem(
            context: context,
            index: 1,
            icon: Assets.documents,
            label: AppStrings.file,
            route: Routes.documentations,
          ),
          _buildNavItem(
            context: context,
            index: 2,
            icon: Assets.profileIcon,
            label: AppStrings.profile,
            route: Routes.profile,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required String icon,
    required String label,
    required String route,
  }) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          context.go(route);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: 150,
        curve: Curves.easeIn,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.darkBlue : AppColors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.white : AppColors.darkBlue,
                BlendMode.srcIn,
              ),
              height: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTextStyles.regular14.copyWith(color: AppColors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
