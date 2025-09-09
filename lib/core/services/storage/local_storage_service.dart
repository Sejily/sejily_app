import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/constants/app_constants.dart';
import 'package:sejily/core/enums/user_role.dart';
import 'package:sejily/core/services/storage/hive_storage_service.dart';
import 'package:sejily/core/services/storage/secure_storage_service.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService(ref);
});

class StorageService {
  final Ref ref;
  StorageService(this.ref);

  Future<void> saveUserRole(UserRole role) async {
    final storage = await ref.read(hiveStorageProvider.future);
    await storage.put(AppConstants.userRoleKey, role.value);
  }

  Future<String?> getUserRole() async {
    final storage = await ref.read(hiveStorageProvider.future);
    final roleValue = storage.get<String>(AppConstants.userRoleKey);
    if (roleValue == null) return null;
    return roleValue;
  }

  Future<bool> isDoctor() async =>
      await getUserRole() == UserRole.healthcareProvider.value;
  Future<String?> getAccessToken() async {
    final storage = await ref.read(secureStorageProvider.future);
    final token = storage.getSecure(AppConstants.accessTokenKey);
    return token;
  }

  Future<String?> getRefreshToken() async {
    final storage = await ref.read(secureStorageProvider.future);
    final token = storage.getSecure(AppConstants.refreshTokenKey);
    return token;
  }

  Future<void> saveAccessToken(String token) async {
    final storage = await ref.read(secureStorageProvider.future);
    await storage.putSecure(AppConstants.accessTokenKey, token);
  }

  Future<void> saveRefreshToken(String token) async {
    final storage = await ref.read(secureStorageProvider.future);
    await storage.putSecure(AppConstants.refreshTokenKey, token);
  }

  Future<void> clearTokens() async {
    final storage = await ref.read(secureStorageProvider.future);
    await storage.deleteSecure(AppConstants.accessTokenKey);
    await storage.deleteSecure(AppConstants.refreshTokenKey);
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    final storage = await ref.read(secureStorageProvider.future);
    await storage.putSecure(AppConstants.accessTokenKey, accessToken);
    await storage.putSecure(AppConstants.refreshTokenKey, refreshToken);
  }

  Future<void> setIsFirstTime(bool value) async {
    final storage = await ref.read(hiveStorageProvider.future);
    await storage.put(AppConstants.isFirstTimeKey, value);
  }

  Future<bool> getIsFirstTime() async {
    final storage = await ref.read(hiveStorageProvider.future);
    return storage.get<bool>(AppConstants.isFirstTimeKey) ?? true;
  }

  Future<void> setIsLoggedIn(bool value) async {
    final storage = await ref.read(hiveStorageProvider.future);
    await storage.put(AppConstants.isLoggedInKey, value);
  }

  Future<bool> getIsLoggedIn() async {
    final storage = await ref.read(hiveStorageProvider.future);
    return storage.get<bool>(AppConstants.isLoggedInKey) ?? false;
  }
}
