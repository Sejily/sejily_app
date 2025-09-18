// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      name: json['fullName'] as String,
      email: json['email'] as String,
      avatarUrl: json['profilePictureUrl'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      phone: json['phoneNumber'] as String?,
      bloodType: json['bloodType'] as String?,
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      medicalConditions: (json['medicalConditions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      allergies: (json['allergies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'fullName': instance.name,
      'email': instance.email,
      'profilePictureUrl': instance.avatarUrl,
      'address': instance.address,
      'city': instance.city,
      'phoneNumber': instance.phone,
      'bloodType': instance.bloodType,
      'height': instance.height,
      'weight': instance.weight,
      'medicalConditions': instance.medicalConditions,
      'allergies': instance.allergies,
    };
