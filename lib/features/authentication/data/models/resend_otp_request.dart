import 'package:json_annotation/json_annotation.dart';

part 'resend_otp_request.g.dart';

@JsonSerializable()
class ResendOtpRequest {
  final String email;

  ResendOtpRequest({required this.email});

  factory ResendOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$ResendOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResendOtpRequestToJson(this);
}
