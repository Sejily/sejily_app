import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  @JsonKey(name: 'fullName')
  final String name;
  final String email;
  @JsonKey(name: 'profilePictureUrl')
  final String? avatarUrl;
  final String? address;
  final String? city;
  @JsonKey(name: 'phoneNumber')
  final String? phone;
  final String? bloodType;
  final double? height;
  final double? weight;
  final List<String>? medicalConditions;
  final List<String>? allergies;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.address,
    this.city,
    this.phone,
    this.bloodType,
    this.height,
    this.weight,
    this.medicalConditions,
    this.allergies,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    String? address,
    String? city,
    String? phone,
    String? bloodType,
    double? height,
    double? weight,
    List<String>? medicalConditions,
    List<String>? allergies,
    String? privacyLevel,
    String? dataRetentionPreference,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      address: address ?? this.address,
      city: city ?? this.city,
      phone: phone ?? this.phone,
      bloodType: bloodType ?? this.bloodType,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      medicalConditions: medicalConditions ?? this.medicalConditions,
      allergies: allergies ?? this.allergies,
    );
  }
}
