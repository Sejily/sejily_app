import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  bool _isSecureStorageInitialized = false;
  static FlutterSecureStorage? _secureStorage;
  Future<void> init() async {
    if (_isSecureStorageInitialized) return;
    AndroidOptions androidOptions = const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    _secureStorage = FlutterSecureStorage(aOptions: androidOptions);
    _isSecureStorageInitialized = true;
  }

  Future<void> putSecure(String key, String value) async =>
      await _secureStorage?.write(key: key, value: value);
  Future<String?> getSecure(String key) async =>
      await _secureStorage?.read(key: key);
  Future<void> deleteSecure(String key) async =>
      await _secureStorage?.delete(key: key);
  Future<void> clearAllSecure() async => await _secureStorage?.deleteAll();
}

final secureStorageProvider = FutureProvider<SecureStorageService>((ref) async {
  final secureStorageService = SecureStorageService();
  await secureStorageService.init();
  return secureStorageService;
});
