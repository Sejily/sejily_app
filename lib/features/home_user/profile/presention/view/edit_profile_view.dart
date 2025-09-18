import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import '../manager/providers/edit_profile_provider.dart';
import '../manager/providers/user_provider.dart';
import '../manager/providers/medical_info_provider.dart';
import '../widgets/custom_text_field.dart';
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
              onSuccess: (u) {
                if (!controllersInitialized) {
                  user = u;
                  _initializeControllers(u);
                  controllersInitialized = true;

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (u.bloodType != null) {
                      ref
                          .read(medicalInfoProvider.notifier)
                          .setBloodType(u.bloodType!);
                    }
                  });
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.editProfile,
                        style: AppTextStyles.bold20.copyWith(
                          color: AppColors.jetBlack,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            u.avatarUrl != null && u.avatarUrl!.isNotEmpty
                            ? NetworkImage(u.avatarUrl!)
                            : const AssetImage(
                                    "assets/images/selected_person.png",
                                  )
                                  as ImageProvider,
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        label: AppStrings.fullNameLabel,
                        controller: nameController,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: AppStrings.emailAddress,
                        controller: emailController,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: AppStrings.address,
                        controller: addressController,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: AppStrings.city,
                        controller: cityController,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: AppStrings.phoneNumber,
                        controller: phoneController,
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        isLoading: editState.isLoading,
                        text: AppStrings.save,
                        loadingText: AppStrings.savingInProgress,
                        onPressed: () {
                          if (user != null) {
                            final updatedUser = user!.copyWith(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              address: addressController.text.trim(),
                              city: cityController.text.trim(),
                              phone: phoneController.text.trim(),
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
