import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sejily/core/constants/app_constants.dart';

class HiveStorageService {
  late Box _localStorageBox;
  bool _isHiveInitialized = false;
  Future<void> init() async {
    if (_isHiveInitialized) return;
    await Hive.initFlutter();
    _localStorageBox = await Hive.openBox(AppConstants.storageBoxName);
    _isHiveInitialized = true;
  }

  Future<void> put<T>(String key, T value) async {
    await _localStorageBox.put(key, value);
  }

  T? get<T>(String key) {
    return _localStorageBox.get(key) as T?;
  }

  Future<void> delete(String key) async {
    await _localStorageBox.delete(key);
  }

  Future<void> clear() async {
    await _localStorageBox.clear();
  }
}

final hiveStorageProvider = FutureProvider<HiveStorageService>((ref) async {
  final service = HiveStorageService();
  await service.init();
  return service;
});
