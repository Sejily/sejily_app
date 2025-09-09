import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/services/storage/local_storage_service.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_assets.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/widgets/custom_button.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": Assets.onboard1,
      "title": AppStrings.onboardingTitle1,
      "subtitle": AppStrings.onboardingSubtitle1,
    },
    {
      "image": Assets.onboard1,
      "title": AppStrings.onBoardingTitle2,
      "subtitle": AppStrings.onBoardingSubtitle2,
    },
    {
      "image": Assets.onboard1,
      "title": AppStrings.onBoardingTitle3,
      "subtitle": AppStrings.onBoardingSubtitle3,
    },
  ];

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      ref.read(storageServiceProvider).setIsFirstTime(false);
      context.go(Routes.selectRole);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  color: AppColors.white,
                  child: Center(
                    child: Transform.translate(
                      offset: const Offset(0, 125),
                      child: Image.asset(
                        onboardingData[index]["image"]!,
                        height: MediaQuery.of(context).size.height * 0.7,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    spreadRadius: 2,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    onboardingData[_currentPage]["title"]!,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bold24.copyWith(
                      color: AppColors.darkBlue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    onboardingData[_currentPage]["subtitle"]!,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regular16.copyWith(
                      color: AppColors.gray,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: List.generate(
                      onboardingData.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.darkBlue
                              : AppColors.lightGray,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    onPressed: _nextPage,
                    text: _currentPage == onboardingData.length - 1
                        ? AppStrings.finish
                        : AppStrings.next,
                  ),

                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      ref.read(storageServiceProvider).setIsFirstTime(false);
                      context.go(Routes.selectRole);
                    },
                    child: Text(
                      AppStrings.skip,
                      style: AppTextStyles.regular16.copyWith(
                        color: AppColors.blackBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
