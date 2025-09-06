import 'dart:io';

class FullDoctorRegistrationRequest {
  // Personal Information
  String? nationality;
  String? nationalId;
  String? phoneNumber;
  String? dateOfBirth;
  String? gender;
  String? address;
  String? city;

  // doctor work data
  String? specialization;
  String? licenseNumber;
  String? hospitalAffiliation;

  // Images
  File? profilePicture;
  File? idPicture;
  File? licensePicture;

  FullDoctorRegistrationRequest({
    this.nationality,
    this.nationalId,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.city,
    this.specialization,
    this.licenseNumber,
    this.hospitalAffiliation,
    this.profilePicture,
    this.idPicture,
    this.licensePicture,
  });

  FullDoctorRegistrationRequest copyWith({
    String? nationality,
    String? nationalId,
    String? phoneNumber,
    String? dateOfBirth,
    String? gender,
    String? address,
    String? city,
    String? specialization,
    String? licenseNumber,
    String? hospitalAffiliation,
    File? profilePicture,
    File? idPicture,
    File? licensePicture,
  }) {
    return FullDoctorRegistrationRequest(
      nationality: nationality ?? this.nationality,
      nationalId: nationalId ?? this.nationalId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      city: city ?? this.city,
      specialization: specialization ?? this.specialization,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      hospitalAffiliation: hospitalAffiliation ?? this.hospitalAffiliation,
      profilePicture: profilePicture ?? this.profilePicture,
      idPicture: idPicture ?? this.idPicture,
      licensePicture: licensePicture ?? this.licensePicture,
    );
  }
}
