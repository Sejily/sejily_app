import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sejily/core/helpers/storage_extension.dart';
import 'package:sejily/core/routes/routes.dart';
import 'package:sejily/core/utils/app_colors.dart';
import 'package:sejily/core/utils/app_strings.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import 'package:sejily/features/authentication/presentation/manager/providers/register_provider.dart';
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
      final registerNotifier = ref.read(registerNotifierProvider.notifier);
      final isDoctor = storage.isDoctor();

      if (isDoctor) {
        final doctorData = ref.read(doctorRegistrationProvider);
        await registerNotifier.completeDoctorRegistrationData(
          request: doctorData,
        );
      } else {
        final patientData = ref.read(patientRegistrationProvider);
        await registerNotifier.completePatientRegistrationData(
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
    ref.listen<AuthState>(registerNotifierProvider, (previous, next) {
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
      isLoading: _isLoading,
      text: AppStrings.finish,
      loadingText: AppStrings.completingRegistration,
      onPressed: _handleFinish,
    );
  }
}
