import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/features/authentication/presentation/manager/providers/progress_provider.dart';

class StepProgressBar extends ConsumerWidget {
  final int totalSteps;
  const StepProgressBar({super.key, this.totalSteps = 6});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(progressProvider);
    final progress = currentStep / totalSteps;

    return Column(
      children: [
        // Step counter
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.gray.withValues(alpha: 0.3),
            color: AppColors.lightGreen,
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}
