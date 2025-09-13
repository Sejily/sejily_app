import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/features/authentication/presentation/view/emergency_contact_page.dart';
import '../manager/providers/emergency_contacts_provider.dart';
import 'package:sejily/core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_bottom_navbar.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/utils/app_strings.dart';

class EmergencyPage extends ConsumerWidget {
  const EmergencyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsState = ref.watch(emergencyContactsProvider);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEE),
                    border: Border.all(color: AppColors.lightRed),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info, color: AppColors.lightRed),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          AppStrings.warning,
                          style: AppTextStyles.regular14.copyWith(
                            color: AppColors.lightRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: AppStrings.addEmergencyContact,
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.darkBlue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EmergencyContactPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                Text(AppStrings.emergency, style: AppTextStyles.semiBold18),
                const SizedBox(height: 16),
                Expanded(
                  child: contactsState.when(
                    data: (contacts) {
                      if (contacts.isEmpty) {
                        return Center(
                          child: Text(
                            "لا توجد جهات طوارئ",
                            style: AppTextStyles.regular14,
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final contact = contacts[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "تفاصيل جهة الطوارئ",
                                  style: AppTextStyles.medium16.copyWith(
                                    color: AppColors.blackBlue,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "الاسم: ${contact.name}",
                                  style: AppTextStyles.regular14,
                                ),
                                Text(
                                  "رقم الهاتف: ${contact.phoneNumber}",
                                  style: AppTextStyles.regular14,
                                ),
                                Text(
                                  "صلة القرابة: ${contact.relation}",
                                  style: AppTextStyles.regular14,
                                ),
                                const SizedBox(height: 24),
                                Center(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: AppColors.lightRed,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                      ),
                                      onPressed: () async {
                                        await ref
                                            .read(
                                              emergencyContactsProvider
                                                  .notifier,
                                            )
                                            .deleteContact(contact.id);
                                      },
                                      child: Text(
                                        "حذف جهة الطوارئ",
                                        style: AppTextStyles.medium14.copyWith(
                                          color: AppColors.lightRed,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, st) => Center(child: Text('حدث خطأ')),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
      ),
    );
  }
}
