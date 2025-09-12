import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_text_styles.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import '../manager/providers/edit_profile_provider.dart';
import '../widgets/custom_text_field.dart';
import '../../data/models/user_model.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final UserModel user;

  const EditProfileScreen({super.key, required this.user});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    addressController = TextEditingController(
      text: widget.user.avatarUrl ?? '',
    );
    cityController = TextEditingController(text: '');
    phoneController = TextEditingController(text: '');
  }

  void _saveProfile() {
    final updatedUser = UserModel(
      id: widget.user.id,
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      avatarUrl: addressController.text.trim(),
    );

    ref.read(editProfileNotifierProvider.notifier).updateProfile(updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editProfileNotifierProvider);

    ref.listen<EditProfileState>(editProfileNotifierProvider, (prev, next) {
      if (next.result != null) {
        next.result!.when(
          onSuccess: (user) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تم حفظ البيانات بنجاح")),
            );
          },
          onFailure: (error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(error.errorMessage)));
          },
        );
      }
    });

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
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
                  backgroundImage: widget.user.avatarUrl != null
                      ? NetworkImage(widget.user.avatarUrl!)
                      : const AssetImage("assets/images/selected_person.png")
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
                  onPressed: state.isLoading ? null : _saveProfile,
                  text: AppStrings.save,
                  child: state.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
