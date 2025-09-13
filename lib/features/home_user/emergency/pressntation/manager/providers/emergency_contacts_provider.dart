import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/emergency_contact_service.dart';
import 'emergency_repository.dart';

final emergencyContactsProvider =
    StateNotifierProvider<
      EmergencyContactsNotifier,
      AsyncValue<List<EmergencyContact>>
    >((ref) {
      final repo = ref.watch(emergencyRepositoryProvider);
      return EmergencyContactsNotifier(repo);
    });

class EmergencyContactsNotifier
    extends StateNotifier<AsyncValue<List<EmergencyContact>>> {
  final EmergencyRepository repo;

  EmergencyContactsNotifier(this.repo) : super(const AsyncLoading()) {
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    state = const AsyncLoading();
    try {
      final contacts = await repo.getContacts();
      state = AsyncData(contacts);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> addContact(EmergencyContact contact) async {
    try {
      await repo.addContact(contact);
      await fetchContacts();
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteContact(String id) async {
    try {
      await repo.deleteContact(id);
      await fetchContacts();
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
