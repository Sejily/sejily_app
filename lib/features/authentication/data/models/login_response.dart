import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final UserData user;

  const LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  bool get isSuccess => accessToken.isNotEmpty && refreshToken.isNotEmpty;
}

@JsonSerializable()
class UserData {
  final String id;
  final String email;
  final String fullName;
  final String role;
  final String? profilePictureUrl;
  final String? phoneNumber;

  const UserData({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    this.profilePictureUrl,
    this.phoneNumber,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
