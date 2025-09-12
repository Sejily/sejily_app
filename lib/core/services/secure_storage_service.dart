import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sejily/core/constants/app_constants.dart';

class StorageService {
  static StorageService? _instance;
  static StorageService get instance => _instance ??= StorageService._();

  StorageService._();

  late Box _box;
  late FlutterSecureStorage _secureStorage;
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();
    _box = await Hive.openBox(AppConstants.storageBoxName);

    const androidOptions = AndroidOptions(encryptedSharedPreferences: true);
    const iosOptions = IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    );

    _secureStorage = const FlutterSecureStorage(
      aOptions: androidOptions,
      iOptions: iosOptions,
    );
    _initialized = true;
  }

  //* Hive
  Future<void> save(String key, dynamic value) async {
    await _box.put(key, value);
  }

  T? get<T>(String key, [T? defaultValue]) {
    return _box.get(key, defaultValue: defaultValue);
  }

  Future<void> remove(String key) async {
    await _box.delete(key);
  }

  Future<void> clearAll() async {
    await _box.clear();
  }

  //* Secure Storage
  Future<void> saveSecure(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getSecure(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> removeSecure(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> clearAllSecure() async {
    await _secureStorage.deleteAll();
  }

  Future<void> setLoggedIn(bool value) async {
    await save(AppConstants.isLoggedInKey, value);
  }

  bool isLoggedIn() {
    return get<bool>(AppConstants.isLoggedInKey, false) ?? false;
  }

  Future<void> clearLoginData() async {
    await remove(AppConstants.isLoggedInKey);
    await clearAllSecure();
  }
}
