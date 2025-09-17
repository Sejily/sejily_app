import 'package:sejily/core/constants/app_constants.dart';
import 'package:sejily/core/enums/user_role.dart';
import 'package:sejily/core/services/secure_storage_service.dart';

extension StorageExtension on StorageService {
  Future<void> saveAuthTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await saveSecure(AppConstants.accessTokenKey, accessToken);
    await saveSecure(AppConstants.refreshTokenKey, refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await getSecure(AppConstants.accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await getSecure(AppConstants.refreshTokenKey);
  }

  Future<bool> hasValidTokens() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();
    return accessToken != null && refreshToken != null;
  }

  Future<void> clearTokens() async {
    await removeSecure(AppConstants.accessTokenKey);
    await removeSecure(AppConstants.refreshTokenKey);
  }

  bool isLoggedIn() {
    return get<bool>(AppConstants.isLoggedInKey) ?? false;
  }

  Future<void> setLoggedIn(bool isLoggedIn) async {
    await save(AppConstants.isLoggedInKey, isLoggedIn);
  }

  bool isFirstTime() {
    return get<bool>(AppConstants.isFirstTimeKey, true) ?? true;
  }

  Future<void> setIsFirstTime(bool isFirstTime) async {
    await save(AppConstants.isFirstTimeKey, isFirstTime);
  }

  Future<void> saveUserRole(UserRole role) async {
    await save(AppConstants.userRoleKey, role.value);
  }

  UserRole? getUserRole() {
    final roleValue = get<String>(AppConstants.userRoleKey);
    if (roleValue == null) return null;

    return UserRole.values.firstWhere(
      (role) => role.value == roleValue,
      orElse: () => UserRole.patient,
    );
  }

  String? getUserRoleValue() {
    return get<String>(AppConstants.userRoleKey);
  }

  bool isDoctor() {
    final role = getUserRole();
    return role == UserRole.healthcareProvider;
  }

  bool isPatient() {
    final role = getUserRole();
    return role == UserRole.patient;
  }

  Future<void> completeLogout() async {
    await clearTokens();
    await setLoggedIn(false);
  }
}

extension StorageExtensionAccess on Object {
  StorageService get storage => StorageService.instance;
}
