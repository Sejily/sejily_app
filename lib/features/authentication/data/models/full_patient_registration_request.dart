import 'dart:io';

class FullPatientRegistrationRequest {
  // Personal Information
  String? nationality;
  String? nationalId;
  String? phoneNumber;
  String? dateOfBirth;
  String? gender;
  String? address;

  // Emergency Contact Information
  String? emergencyContactName;
  String? emergencyContactPhone;
  String? emergencyContactRelation;

  // Images
  File? profilePicture;
  File? idPicture;

  FullPatientRegistrationRequest({
    this.nationality,
    this.nationalId,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.emergencyContactRelation,
    this.profilePicture,
    this.idPicture,
  });

  FullPatientRegistrationRequest copyWith({
    String? nationality,
    String? nationalId,
    String? phoneNumber,
    String? dateOfBirth,
    String? gender,
    String? address,
    String? emergencyContactName,
    String? emergencyContactPhone,
    String? emergencyContactRelation,
    File? profilePicture,
    File? idPicture,
  }) {
    return FullPatientRegistrationRequest(
      nationality: nationality ?? this.nationality,
      nationalId: nationalId ?? this.nationalId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactPhone:
          emergencyContactPhone ?? this.emergencyContactPhone,
      emergencyContactRelation:
          emergencyContactRelation ?? this.emergencyContactRelation,
      profilePicture: profilePicture ?? this.profilePicture,
      idPicture: idPicture ?? this.idPicture,
    );
  }
}
