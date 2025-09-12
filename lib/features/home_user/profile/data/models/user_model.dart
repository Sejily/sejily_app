class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String? address;
  final String? city;
  final String? phone;
  final String? bloodType;
  final double? height;
  final double? weight;
  final List<String>? medicalConditions;
  final List<String>? allergies;
  final String? privacyLevel;
  final String? dataRetentionPreference;

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
    this.privacyLevel,
    this.dataRetentionPreference,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['fullName'] ?? '',
      email: json['email'] ?? '',
      avatarUrl: json['profilePictureUrl'],
      address: json['address'],
      city: json['city'] ?? '',
      phone: json['phoneNumber'],
      bloodType: json['bloodType'],
      height: (json['height'] != null)
          ? double.tryParse(json['height'].toString())
          : null,
      weight: (json['weight'] != null)
          ? double.tryParse(json['weight'].toString())
          : null,
      medicalConditions: (json['medicalConditions'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      allergies: (json['allergies'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      privacyLevel: json['privacyLevel'],
      dataRetentionPreference: json['dataRetentionPreference'],
    );
  }

  Map<String, dynamic> toJson() => {
    'fullName': name,
    'email': email,
    'phoneNumber': phone ?? '',
    'address': address ?? '',
    'city': city ?? '',
    'bloodType': bloodType ?? '',
    'height': height ?? 0,
    'weight': weight ?? 0,
    'medicalConditions': medicalConditions ?? [],
    'allergies': allergies ?? [],
    'privacyLevel': privacyLevel ?? 'STANDARD',
    'dataRetentionPreference': dataRetentionPreference ?? 'STANDARD',
  };

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
      privacyLevel: privacyLevel ?? this.privacyLevel,
      dataRetentionPreference:
          dataRetentionPreference ?? this.dataRetentionPreference,
    );
  }
}
