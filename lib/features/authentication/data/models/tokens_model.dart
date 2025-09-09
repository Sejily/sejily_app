import 'package:json_annotation/json_annotation.dart';

part 'tokens_model.g.dart';

@JsonSerializable()
class TokensModel {
  @JsonKey(name: 'accessToken')
  final String accessToken;

  @JsonKey(name: 'refreshToken')
  final String refreshToken;

  const TokensModel({required this.accessToken, required this.refreshToken});

  factory TokensModel.fromJson(Map<String, dynamic> json) =>
      _$TokensModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokensModelToJson(this);
}
