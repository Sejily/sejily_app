import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/helpers/storage_extension.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/features/authentication/data/models/register_request.dart';
import 'package:sejily/features/authentication/presentation/manager/providers/register_provider.dart';

class RegisterButton extends ConsumerStatefulWidget {
  const RegisterButton({
    super.key,
    required TextEditingController emailController,
    required GlobalKey<FormState> formKey,
    required TextEditingController passwordController,
    required TextEditingController nameController,
  }) : _emailController = emailController,
       _formKey = formKey,
       _passwordController = passwordController,
       _nameController = nameController;

  final TextEditingController _emailController;
  final GlobalKey<FormState> _formKey;
  final TextEditingController _passwordController;
  final TextEditingController _nameController;

  @override
  ConsumerState<RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends ConsumerState<RegisterButton> {
  Future<void> _onRegisterPressed() async {
    if (!(widget._formKey.currentState?.validate() ?? false)) {
      return;
    }

    try {
      final role = storage.getUserRoleValue();

      if (role == null) {
        _showSnackBar(
          'دور المستخدم غير صالح. يرجى المحاولة مرة أخرى.',
          AppColors.lightRed,
        );
        return;
      }

      await ref
          .read(registerNotifierProvider.notifier)
          .register(
            registerRequest: RegisterRequest(
              email: widget._emailController.text.trim(),
              password: widget._passwordController.text.trim(),
              fullName: widget._nameController.text.trim(),
              role: role,
            ),
          );
    } catch (e) {
      _showSnackBar('حدث خطأ أثناء التسجيل: ${e.toString()}', AppColors.red);
    }
  }

  void _showSnackBar(String message, Color color) {
    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(registerNotifierProvider)
        .whenOrNull(loading: () => true);
    // Listen to auth state changes for navigation and error handling
    ref.listen(registerNotifierProvider, (previous, next) {
      next.maybeWhen(
        success: () {
          context.push(
            Routes.otpVerification,
            extra: {
              'email': widget._emailController.text.trim(),
              'route': Routes.completeUserData,
            },
          );
        },
        failure: (error) {
          _showSnackBar(error.errorMessage, AppColors.red);
        },
        orElse: () {},
      );
    });

    return CustomButton(
      text: AppStrings.createNewAccount,
      isLoading: isLoading,
      onPressed: _onRegisterPressed,
    );
  }
}
