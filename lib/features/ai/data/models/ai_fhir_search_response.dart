import 'package:json_annotation/json_annotation.dart';

part 'ai_fhir_search_response.g.dart';

@JsonSerializable()
class AIFhirSearchResponse {
  final bool success;
  @JsonKey(name: 'fhir_data')
  final FhirBundle fhirData;
  @JsonKey(name: 'file_id')
  final String fileId;
  @JsonKey(name: 'searched_at')
  final DateTime searchedAt;

  AIFhirSearchResponse({
    required this.success,
    required this.fhirData,
    required this.fileId,
    required this.searchedAt,
  });

  factory AIFhirSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$AIFhirSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AIFhirSearchResponseToJson(this);
}

@JsonSerializable()
class FhirBundle {
  final String resourceType;
  final String id;
  final String type;
  final List<FhirEntry> entry;

  FhirBundle({
    required this.resourceType,
    required this.id,
    required this.type,
    required this.entry,
  });

  factory FhirBundle.fromJson(Map<String, dynamic> json) =>
      _$FhirBundleFromJson(json);

  Map<String, dynamic> toJson() => _$FhirBundleToJson(this);
}

@JsonSerializable()
class FhirEntry {
  final FhirResource resource;

  FhirEntry({required this.resource});

  factory FhirEntry.fromJson(Map<String, dynamic> json) =>
      _$FhirEntryFromJson(json);

  Map<String, dynamic> toJson() => _$FhirEntryToJson(this);
}

@JsonSerializable()
class FhirResource {
  final String resourceType;
  final String? id;
  final String? gender;
  final List<FhirName>? name;
  final String? status;
  final String? intent;
  final FhirMedicationCodeableConcept? medicationCodeableConcept;

  FhirResource({
    required this.resourceType,
    this.id,
    this.gender,
    this.name,
    this.status,
    this.intent,
    this.medicationCodeableConcept,
  });

  factory FhirResource.fromJson(Map<String, dynamic> json) =>
      _$FhirResourceFromJson(json);

  Map<String, dynamic> toJson() => _$FhirResourceToJson(this);
}

@JsonSerializable()
class FhirName {
  final String text;

  FhirName({required this.text});

  factory FhirName.fromJson(Map<String, dynamic> json) =>
      _$FhirNameFromJson(json);

  Map<String, dynamic> toJson() => _$FhirNameToJson(this);
}

@JsonSerializable()
class FhirMedicationCodeableConcept {
  final String text;

  FhirMedicationCodeableConcept({required this.text});

  factory FhirMedicationCodeableConcept.fromJson(Map<String, dynamic> json) =>
      _$FhirMedicationCodeableConceptFromJson(json);

  Map<String, dynamic> toJson() => _$FhirMedicationCodeableConceptToJson(this);
}
