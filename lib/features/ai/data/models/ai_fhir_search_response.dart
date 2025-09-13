import 'package:json_annotation/json_annotation.dart';

part 'ai_fhir_search_response.g.dart';

@JsonSerializable()
class AIFhirSearchResponse {
  final bool? success;
  @JsonKey(name: 'fhir_data')
  final FhirBundle? fhirData;
  @JsonKey(name: 'file_id')
  final String? fileId;
  @JsonKey(name: 'searched_at')
  final String? searchedAt;

  AIFhirSearchResponse({
    this.success,
    this.fhirData,
    this.fileId,
    this.searchedAt,
  });

  factory AIFhirSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$AIFhirSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AIFhirSearchResponseToJson(this);
}

@JsonSerializable()
class FhirBundle {
  final String? resourceType;
  final String? id;
  final FhirMeta? meta;
  final String? type;
  final List<FhirEntry>? entry;

  FhirBundle({this.resourceType, this.id, this.meta, this.type, this.entry});

  factory FhirBundle.fromJson(Map<String, dynamic> json) =>
      _$FhirBundleFromJson(json);

  Map<String, dynamic> toJson() => _$FhirBundleToJson(this);
}

@JsonSerializable()
class FhirMeta {
  final String? lastUpdated;
  final List<String>? profile;

  FhirMeta({this.lastUpdated, this.profile});

  factory FhirMeta.fromJson(Map<String, dynamic> json) =>
      _$FhirMetaFromJson(json);

  Map<String, dynamic> toJson() => _$FhirMetaToJson(this);
}

@JsonSerializable()
class FhirEntry {
  final String? fullUrl;
  final FhirResource? resource;

  FhirEntry({this.fullUrl, this.resource});

  factory FhirEntry.fromJson(Map<String, dynamic> json) =>
      _$FhirEntryFromJson(json);

  Map<String, dynamic> toJson() => _$FhirEntryToJson(this);
}

@JsonSerializable()
class FhirResource {
  final String? resourceType;
  final String? id;
  final FhirMeta? meta;
  final FhirText? text;
  final bool? active;
  final List<FhirName>? name;
  final String? gender;
  final String? status;
  final String? intent;
  final FhirMedicationCodeableConcept? medicationCodeableConcept;
  final FhirSubject? subject;
  final String? authoredOn;
  final List<FhirDosageInstruction>? dosageInstruction;
  final FhirDispenseRequest? dispenseRequest;

  FhirResource({
    this.resourceType,
    this.id,
    this.meta,
    this.text,
    this.active,
    this.name,
    this.gender,
    this.status,
    this.intent,
    this.medicationCodeableConcept,
    this.subject,
    this.authoredOn,
    this.dosageInstruction,
    this.dispenseRequest,
  });

  factory FhirResource.fromJson(Map<String, dynamic> json) =>
      _$FhirResourceFromJson(json);

  Map<String, dynamic> toJson() => _$FhirResourceToJson(this);
}

@JsonSerializable()
class FhirText {
  final String? status;
  final String? div;

  FhirText({this.status, this.div});

  factory FhirText.fromJson(Map<String, dynamic> json) =>
      _$FhirTextFromJson(json);

  Map<String, dynamic> toJson() => _$FhirTextToJson(this);
}

@JsonSerializable()
class FhirName {
  final String? text;

  FhirName({this.text});

  factory FhirName.fromJson(Map<String, dynamic> json) =>
      _$FhirNameFromJson(json);

  Map<String, dynamic> toJson() => _$FhirNameToJson(this);
}

@JsonSerializable()
class FhirMedicationCodeableConcept {
  final List<FhirCoding>? coding;
  final String? text;

  FhirMedicationCodeableConcept({this.coding, this.text});

  factory FhirMedicationCodeableConcept.fromJson(Map<String, dynamic> json) =>
      _$FhirMedicationCodeableConceptFromJson(json);

  Map<String, dynamic> toJson() => _$FhirMedicationCodeableConceptToJson(this);
}

@JsonSerializable()
class FhirCoding {
  final String? system;
  final String? code;
  final String? display;

  FhirCoding({this.system, this.code, this.display});

  factory FhirCoding.fromJson(Map<String, dynamic> json) =>
      _$FhirCodingFromJson(json);

  Map<String, dynamic> toJson() => _$FhirCodingToJson(this);
}

@JsonSerializable()
class FhirSubject {
  final String? reference;
  final String? display;

  FhirSubject({this.reference, this.display});

  factory FhirSubject.fromJson(Map<String, dynamic> json) =>
      _$FhirSubjectFromJson(json);

  Map<String, dynamic> toJson() => _$FhirSubjectToJson(this);
}

@JsonSerializable()
class FhirDosageInstruction {
  final String? text;
  final FhirTiming? timing;
  final List<FhirDoseAndRate>? doseAndRate;
  final FhirRoute? route;
  final List<FhirCodeableConcept>? additionalInstruction;

  FhirDosageInstruction({
    this.text,
    this.timing,
    this.doseAndRate,
    this.route,
    this.additionalInstruction,
  });

  factory FhirDosageInstruction.fromJson(Map<String, dynamic> json) =>
      _$FhirDosageInstructionFromJson(json);

  Map<String, dynamic> toJson() => _$FhirDosageInstructionToJson(this);
}

@JsonSerializable()
class FhirTiming {
  final FhirRepeat? repeat;
  final FhirBoundsDuration? boundsDuration;
  final List<String>? when;

  FhirTiming({this.repeat, this.boundsDuration, this.when});

  factory FhirTiming.fromJson(Map<String, dynamic> json) =>
      _$FhirTimingFromJson(json);

  Map<String, dynamic> toJson() => _$FhirTimingToJson(this);
}

@JsonSerializable()
class FhirRepeat {
  final int? frequency;
  final int? period;
  final String? periodUnit;
  final List<String>? when;
  final int? duration;
  final String? durationUnit;

  FhirRepeat({
    this.frequency,
    this.period,
    this.periodUnit,
    this.when,
    this.duration,
    this.durationUnit,
  });

  factory FhirRepeat.fromJson(Map<String, dynamic> json) =>
      _$FhirRepeatFromJson(json);

  Map<String, dynamic> toJson() => _$FhirRepeatToJson(this);
}

@JsonSerializable()
class FhirBoundsDuration {
  final int? value;
  final String? unit;
  final String? system;
  final String? code;

  FhirBoundsDuration({this.value, this.unit, this.system, this.code});

  factory FhirBoundsDuration.fromJson(Map<String, dynamic> json) =>
      _$FhirBoundsDurationFromJson(json);

  Map<String, dynamic> toJson() => _$FhirBoundsDurationToJson(this);
}

@JsonSerializable()
class FhirDoseAndRate {
  final FhirType? type;
  final FhirDoseQuantity? doseQuantity;

  FhirDoseAndRate({this.type, this.doseQuantity});

  factory FhirDoseAndRate.fromJson(Map<String, dynamic> json) =>
      _$FhirDoseAndRateFromJson(json);

  Map<String, dynamic> toJson() => _$FhirDoseAndRateToJson(this);
}

@JsonSerializable()
class FhirType {
  final List<FhirCoding>? coding;

  FhirType({this.coding});

  factory FhirType.fromJson(Map<String, dynamic> json) =>
      _$FhirTypeFromJson(json);

  Map<String, dynamic> toJson() => _$FhirTypeToJson(this);
}

@JsonSerializable()
class FhirDoseQuantity {
  final int? value;
  final String? unit;
  final String? system;
  final String? code;

  FhirDoseQuantity({this.value, this.unit, this.system, this.code});

  factory FhirDoseQuantity.fromJson(Map<String, dynamic> json) =>
      _$FhirDoseQuantityFromJson(json);

  Map<String, dynamic> toJson() => _$FhirDoseQuantityToJson(this);
}

@JsonSerializable()
class FhirRoute {
  final List<FhirCoding>? coding;
  final String? text;

  FhirRoute({this.coding, this.text});

  factory FhirRoute.fromJson(Map<String, dynamic> json) =>
      _$FhirRouteFromJson(json);

  Map<String, dynamic> toJson() => _$FhirRouteToJson(this);
}

@JsonSerializable()
class FhirCodeableConcept {
  final List<FhirCoding>? coding;
  final String? text;

  FhirCodeableConcept({this.coding, this.text});

  factory FhirCodeableConcept.fromJson(Map<String, dynamic> json) =>
      _$FhirCodeableConceptFromJson(json);

  Map<String, dynamic> toJson() => _$FhirCodeableConceptToJson(this);
}

@JsonSerializable()
class FhirDispenseRequest {
  final int? numberOfRepeatsAllowed;
  final FhirExpectedSupplyDuration? expectedSupplyDuration;

  FhirDispenseRequest({
    this.numberOfRepeatsAllowed,
    this.expectedSupplyDuration,
  });

  factory FhirDispenseRequest.fromJson(Map<String, dynamic> json) =>
      _$FhirDispenseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FhirDispenseRequestToJson(this);
}

@JsonSerializable()
class FhirExpectedSupplyDuration {
  final int? value;
  final String? unit;
  final String? system;
  final String? code;

  FhirExpectedSupplyDuration({this.value, this.unit, this.system, this.code});

  factory FhirExpectedSupplyDuration.fromJson(Map<String, dynamic> json) =>
      _$FhirExpectedSupplyDurationFromJson(json);

  Map<String, dynamic> toJson() => _$FhirExpectedSupplyDurationToJson(this);
}
