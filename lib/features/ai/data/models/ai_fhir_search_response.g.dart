// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_fhir_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIFhirSearchResponse _$AIFhirSearchResponseFromJson(
        Map<String, dynamic> json) =>
    AIFhirSearchResponse(
      success: json['success'] as bool,
      fhirData: FhirBundle.fromJson(json['fhir_data'] as Map<String, dynamic>),
      fileId: json['file_id'] as String,
      searchedAt: DateTime.parse(json['searched_at'] as String),
    );

Map<String, dynamic> _$AIFhirSearchResponseToJson(
        AIFhirSearchResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'fhir_data': instance.fhirData,
      'file_id': instance.fileId,
      'searched_at': instance.searchedAt.toIso8601String(),
    };

FhirBundle _$FhirBundleFromJson(Map<String, dynamic> json) => FhirBundle(
      resourceType: json['resourceType'] as String,
      id: json['id'] as String,
      type: json['type'] as String,
      entry: (json['entry'] as List<dynamic>)
          .map((e) => FhirEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FhirBundleToJson(FhirBundle instance) =>
    <String, dynamic>{
      'resourceType': instance.resourceType,
      'id': instance.id,
      'type': instance.type,
      'entry': instance.entry,
    };

FhirEntry _$FhirEntryFromJson(Map<String, dynamic> json) => FhirEntry(
      resource: FhirResource.fromJson(json['resource'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FhirEntryToJson(FhirEntry instance) => <String, dynamic>{
      'resource': instance.resource,
    };

FhirResource _$FhirResourceFromJson(Map<String, dynamic> json) => FhirResource(
      resourceType: json['resourceType'] as String,
      id: json['id'] as String?,
      gender: json['gender'] as String?,
      name: (json['name'] as List<dynamic>?)
          ?.map((e) => FhirName.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      intent: json['intent'] as String?,
      medicationCodeableConcept: json['medicationCodeableConcept'] == null
          ? null
          : FhirMedicationCodeableConcept.fromJson(
              json['medicationCodeableConcept'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FhirResourceToJson(FhirResource instance) =>
    <String, dynamic>{
      'resourceType': instance.resourceType,
      'id': instance.id,
      'gender': instance.gender,
      'name': instance.name,
      'status': instance.status,
      'intent': instance.intent,
      'medicationCodeableConcept': instance.medicationCodeableConcept,
    };

FhirName _$FhirNameFromJson(Map<String, dynamic> json) => FhirName(
      text: json['text'] as String,
    );

Map<String, dynamic> _$FhirNameToJson(FhirName instance) => <String, dynamic>{
      'text': instance.text,
    };

FhirMedicationCodeableConcept _$FhirMedicationCodeableConceptFromJson(
        Map<String, dynamic> json) =>
    FhirMedicationCodeableConcept(
      text: json['text'] as String,
    );

Map<String, dynamic> _$FhirMedicationCodeableConceptToJson(
        FhirMedicationCodeableConcept instance) =>
    <String, dynamic>{
      'text': instance.text,
    };
