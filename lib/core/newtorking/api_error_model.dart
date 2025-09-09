import 'package:json_annotation/json_annotation.dart';
import 'package:sejily/core/helpers/string_extensions.dart';
import 'package:sejily/core/utils/app_strings.dart';

part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  @JsonKey(name: 'message')
  final List<String?>? errorMessages;
  @JsonKey(name: 'error')
  final String? message;
  final int? statusCode;

  const ApiErrorModel({this.errorMessages, this.message, this.statusCode});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  String get errorMessage => errorMessages.isNullOrEmpty()
      ? message ?? AppStrings.unexpectedError
      : allMessages;

  String get allMessages => errorMessages!.join('\n');
}
