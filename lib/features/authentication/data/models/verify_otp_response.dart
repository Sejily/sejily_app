import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_response.g.dart';

@JsonSerializable()
class VerifyOtpResponse {
  final String accessToken;
  final String refreshToken;

  @JsonKey(name: 'user', includeFromJson: false, includeToJson: false)
  final Map<String, dynamic>? user;

  const VerifyOtpResponse({
    required this.accessToken,
    required this.refreshToken,
    this.user,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpResponseToJson(this);

  bool get isSuccess => accessToken.isNotEmpty && refreshToken.isNotEmpty;
}
