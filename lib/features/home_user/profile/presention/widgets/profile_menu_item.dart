import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';

class ProfileMenuItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
          color ?? AppColors.darkBlue,
          BlendMode.srcIn,
        ),
        height: 24,
      ),
      title: Text(
        title,
        style: AppTextStyles.semiBold16.copyWith(
          color: color ?? AppColors.jetBlack,
        ),
      ),
      trailing: const Icon(
        CupertinoIcons.chevron_left,
        color: AppColors.darkBlue,
        size: 18,
      ),
      onTap: onTap,
    );
  }
}
