import 'package:dio/dio.dart';
import '../../../../../../core/newtorking/dio_factory.dart';
import '../../../data/models/emergency_contact_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emergencyRepositoryProvider = Provider<EmergencyRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return EmergencyRepository(dio);
});

class EmergencyRepository {
  final Dio _dio;

  EmergencyRepository(this._dio);

  Future<List<EmergencyContact>> getContacts() async {
    final response = await _dio.get('/users/emergency-contacts');
    final data = response.data['emergencyContacts'] as List;
    return data.map((e) => EmergencyContact.fromJson(e)).toList();
  }

  Future<void> addContact(EmergencyContact contact) async {
    await _dio.post('/users/emergency-contacts', data: contact.toJson());
  }

  Future<void> deleteContact(String id) async {
    await _dio.delete('/users/emergency-contacts/$id');
  }
}
