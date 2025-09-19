import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/helpers/string_extensions.dart';
import 'package:sejily/core/utils/app_assets.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/widgets/build_field_with_label.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/core/widgets/custom_text_field.dart';
import 'package:sejily/features/authentication/presentation/widgets/phone_number_field.dart';
import '../manager/providers/edit_profile_provider.dart';
import '../manager/providers/user_provider.dart';
import '../manager/providers/medical_info_provider.dart';
import '../../data/models/user_model.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController phoneController;
  String _selectedCountryCode = ' +20 ';

  UserModel? user;
  bool controllersInitialized = false;

  void _initializeControllers(UserModel user) {
    nameController = TextEditingController(text: user.name);
    emailController = TextEditingController(text: user.email);
    addressController = TextEditingController(text: user.address ?? '');
    cityController = TextEditingController(text: user.city ?? '');
    phoneController = TextEditingController(text: user.phone ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final editState = ref.watch(editProfileNotifierProvider);

    ref.listen<EditProfileState>(editProfileNotifierProvider, (prev, next) {
      if (next.success != null) {
        if (next.success!) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.errorMessage ?? AppStrings.savedSuccessfully),
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.errorMessage ?? AppStrings.saveFailed)),
          );
        }
      }
    });

    final userProfile = ref.watch(userProfileProvider);

    return Scaffold(
      body: SafeArea(
        child: userProfile.when(
          data: (apiResult) {
            return apiResult.when(
              onSuccess: (userData) {
                if (!controllersInitialized) {
                  user = userData;
                  _initializeControllers(userData);
                  controllersInitialized = true;

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (userData.bloodType != null) {
                      ref
                          .read(medicalInfoProvider.notifier)
                          .setBloodType(userData.bloodType!);
                    }
                  });
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      _header(userData),
                      const SizedBox(height: 30),
                      _userTextFields(),
                      const SizedBox(height: 40),
                      CustomButton(
                        isLoading: editState.isLoading,
                        text: AppStrings.saveChanges,
                        loadingText: AppStrings.savingInProgress,
                        onPressed: () {
                          if (user != null) {
                            final updatedUser = user!.copyWith(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              address: addressController.text.trim(),
                              city: cityController.text.trim(),
                              phone:
                                  '$_selectedCountryCode${phoneController.text.trim()}',
                            );

                            ref
                                .read(editProfileNotifierProvider.notifier)
                                .updateProfile(updatedUser);
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
              onFailure: (e) {
                return Center(child: Text(e.errorMessage));
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, st) => const Center(child: Text(AppStrings.saveError)),
        ),
      ),
    );
  }

  Column _userTextFields() {
    return Column(
      children: [
        BuildFieldWithLabel(
          label: AppStrings.fullNameLabel,
          child: CustomTextField(
            hintText: nameController.text,
            controller: nameController,
          ),
        ),
        const SizedBox(height: 16),
        BuildFieldWithLabel(
          label: AppStrings.emailAddress,
          child: CustomTextField(
            hintText: emailController.text,
            controller: emailController,
            canChange: false,
          ),
        ),
        const SizedBox(height: 16),
        BuildFieldWithLabel(
          label: AppStrings.address,
          child: CustomTextField(
            hintText: addressController.text,
            controller: addressController,
          ),
        ),

        const SizedBox(height: 16),
        BuildFieldWithLabel(
          required: true,
          label: AppStrings.city,
          child: CustomTextField(
            hintText: cityController.text,
            controller: cityController,
          ),
        ),
        const SizedBox(height: 16),
        BuildFieldWithLabel(
          required: true,
          label: AppStrings.phoneNumber,
          child: PhoneNumberField(
            initialCountryCode: _selectedCountryCode,
            onCountryCodeChanged: (countryCode) {
              setState(() {
                _selectedCountryCode = countryCode;
              });
            },
            controller: phoneController,
          ),
        ),
      ],
    );
  }

  Column _header(UserModel userData) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(CupertinoIcons.left_chevron),
              onPressed: () => context.pop(),
            ),
            Spacer(),
            Text(
              AppStrings.editProfile,
              style: AppTextStyles.bold24.copyWith(color: AppColors.jetBlack),
            ),
            Spacer(),
          ],
        ),
        const SizedBox(height: 20),
        CircleAvatar(
          radius: 50,
          backgroundImage: !userData.avatarUrl.isNullOrEmpty()
              ? NetworkImage(userData.avatarUrl!)
              : const AssetImage(Assets.selectedPerson),
        ),
      ],
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
