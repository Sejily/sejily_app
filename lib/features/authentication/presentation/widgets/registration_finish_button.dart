import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/services/storage/local_storage_service.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/features/authentication/presentation/manager/providers/auth_provider.dart';
import 'package:sejily/features/authentication/presentation/manager/auth_state.dart';

class RegistrationFinishButton extends ConsumerStatefulWidget {
  const RegistrationFinishButton({super.key, required this.completeData});
  final Future<void> Function() completeData;

  @override
  ConsumerState<RegistrationFinishButton> createState() =>
      _RegistrationFinishButtonState();
}

class _RegistrationFinishButtonState
    extends ConsumerState<RegistrationFinishButton> {
  bool _isLoading = false;

  Future<void> _handleFinish() async {
    setState(() => _isLoading = true);

    try {
      await widget.completeData();
      final authNotifier = ref.read(authNotifierProvider.notifier);
      final isDoctor = await ref.read(storageServiceProvider).isDoctor();

      if (isDoctor) {
        final doctorData = ref.read(doctorRegistrationProvider);
        await authNotifier.completeDoctorRegistrationData(request: doctorData);
      } else {
        final patientData = ref.read(patientRegistrationProvider);
        await authNotifier.completePatientRegistrationData(
          request: patientData,
        );
      }
    } catch (e) {
      if (mounted) {
        _showError(e.toString());
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSuccessAndNavigate() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppStrings.registrationCompletedSuccessfully),
        backgroundColor: Colors.green,
      ),
    );

    // Navigate to home or dashboard
    context.go(Routes.dataReview);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.lightRed),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {},
        success: () {
          if (mounted) {
            setState(() => _isLoading = false);
            _showSuccessAndNavigate();
          }
        },
        failure: (error) {
          if (mounted) {
            _showError(error.message ?? AppStrings.registrationFailed);
            setState(() => _isLoading = false);
          }
        },
      );
    });
    return CustomButton(
      onPressed: _isLoading ? null : _handleFinish,
      text: _isLoading ? AppStrings.completingRegistration : AppStrings.finish,
    );
  }
}
