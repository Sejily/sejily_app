// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiErrorModel _$ApiErrorModelFromJson(Map<String, dynamic> json) =>
    ApiErrorModel(
      errorMessages: (json['message'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      message: json['error'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ApiErrorModelToJson(ApiErrorModel instance) =>
    <String, dynamic>{
      'message': instance.errorMessages,
      'error': instance.message,
      'statusCode': instance.statusCode,
    };
