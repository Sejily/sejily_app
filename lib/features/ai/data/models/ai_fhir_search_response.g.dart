// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_fhir_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIFhirSearchResponse _$AIFhirSearchResponseFromJson(
        Map<String, dynamic> json) =>
    AIFhirSearchResponse(
      success: json['success'] as bool?,
      fhirData: json['fhir_data'] == null
          ? null
          : FhirBundle.fromJson(json['fhir_data'] as Map<String, dynamic>),
      fileId: json['file_id'] as String?,
      searchedAt: json['searched_at'] as String?,
    );

Map<String, dynamic> _$AIFhirSearchResponseToJson(
        AIFhirSearchResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'fhir_data': instance.fhirData,
      'file_id': instance.fileId,
      'searched_at': instance.searchedAt,
    };

FhirBundle _$FhirBundleFromJson(Map<String, dynamic> json) => FhirBundle(
      resourceType: json['resourceType'] as String?,
      id: json['id'] as String?,
      meta: json['meta'] == null
          ? null
          : FhirMeta.fromJson(json['meta'] as Map<String, dynamic>),
      type: json['type'] as String?,
      entry: (json['entry'] as List<dynamic>?)
          ?.map((e) => FhirEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FhirBundleToJson(FhirBundle instance) =>
    <String, dynamic>{
      'resourceType': instance.resourceType,
      'id': instance.id,
      'meta': instance.meta,
      'type': instance.type,
      'entry': instance.entry,
    };

FhirMeta _$FhirMetaFromJson(Map<String, dynamic> json) => FhirMeta(
      lastUpdated: json['lastUpdated'] as String?,
      profile:
          (json['profile'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FhirMetaToJson(FhirMeta instance) => <String, dynamic>{
      'lastUpdated': instance.lastUpdated,
      'profile': instance.profile,
    };

FhirEntry _$FhirEntryFromJson(Map<String, dynamic> json) => FhirEntry(
      fullUrl: json['fullUrl'] as String?,
      resource: json['resource'] == null
          ? null
          : FhirResource.fromJson(json['resource'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FhirEntryToJson(FhirEntry instance) => <String, dynamic>{
      'fullUrl': instance.fullUrl,
      'resource': instance.resource,
    };

FhirResource _$FhirResourceFromJson(Map<String, dynamic> json) => FhirResource(
      resourceType: json['resourceType'] as String?,
      id: json['id'] as String?,
      meta: json['meta'] == null
          ? null
          : FhirMeta.fromJson(json['meta'] as Map<String, dynamic>),
      text: json['text'] == null
          ? null
          : FhirText.fromJson(json['text'] as Map<String, dynamic>),
      active: json['active'] as bool?,
      name: (json['name'] as List<dynamic>?)
          ?.map((e) => FhirName.fromJson(e as Map<String, dynamic>))
          .toList(),
      gender: json['gender'] as String?,
      status: json['status'] as String?,
      intent: json['intent'] as String?,
      medicationCodeableConcept: json['medicationCodeableConcept'] == null
          ? null
          : FhirMedicationCodeableConcept.fromJson(
              json['medicationCodeableConcept'] as Map<String, dynamic>),
      subject: json['subject'] == null
          ? null
          : FhirSubject.fromJson(json['subject'] as Map<String, dynamic>),
      authoredOn: json['authoredOn'] as String?,
      dosageInstruction: (json['dosageInstruction'] as List<dynamic>?)
          ?.map(
              (e) => FhirDosageInstruction.fromJson(e as Map<String, dynamic>))
          .toList(),
      dispenseRequest: json['dispenseRequest'] == null
          ? null
          : FhirDispenseRequest.fromJson(
              json['dispenseRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FhirResourceToJson(FhirResource instance) =>
    <String, dynamic>{
      'resourceType': instance.resourceType,
      'id': instance.id,
      'meta': instance.meta,
      'text': instance.text,
      'active': instance.active,
      'name': instance.name,
      'gender': instance.gender,
      'status': instance.status,
      'intent': instance.intent,
      'medicationCodeableConcept': instance.medicationCodeableConcept,
      'subject': instance.subject,
      'authoredOn': instance.authoredOn,
      'dosageInstruction': instance.dosageInstruction,
      'dispenseRequest': instance.dispenseRequest,
    };

FhirText _$FhirTextFromJson(Map<String, dynamic> json) => FhirText(
      status: json['status'] as String?,
      div: json['div'] as String?,
    );

Map<String, dynamic> _$FhirTextToJson(FhirText instance) => <String, dynamic>{
      'status': instance.status,
      'div': instance.div,
    };

FhirName _$FhirNameFromJson(Map<String, dynamic> json) => FhirName(
      text: json['text'] as String?,
    );

Map<String, dynamic> _$FhirNameToJson(FhirName instance) => <String, dynamic>{
      'text': instance.text,
    };

FhirMedicationCodeableConcept _$FhirMedicationCodeableConceptFromJson(
        Map<String, dynamic> json) =>
    FhirMedicationCodeableConcept(
      coding: (json['coding'] as List<dynamic>?)
          ?.map((e) => FhirCoding.fromJson(e as Map<String, dynamic>))
          .toList(),
      text: json['text'] as String?,
    );

Map<String, dynamic> _$FhirMedicationCodeableConceptToJson(
        FhirMedicationCodeableConcept instance) =>
    <String, dynamic>{
      'coding': instance.coding,
      'text': instance.text,
    };

FhirCoding _$FhirCodingFromJson(Map<String, dynamic> json) => FhirCoding(
      system: json['system'] as String?,
      code: json['code'] as String?,
      display: json['display'] as String?,
    );

Map<String, dynamic> _$FhirCodingToJson(FhirCoding instance) =>
    <String, dynamic>{
      'system': instance.system,
      'code': instance.code,
      'display': instance.display,
    };

FhirSubject _$FhirSubjectFromJson(Map<String, dynamic> json) => FhirSubject(
      reference: json['reference'] as String?,
      display: json['display'] as String?,
    );

Map<String, dynamic> _$FhirSubjectToJson(FhirSubject instance) =>
    <String, dynamic>{
      'reference': instance.reference,
      'display': instance.display,
    };

FhirDosageInstruction _$FhirDosageInstructionFromJson(
        Map<String, dynamic> json) =>
    FhirDosageInstruction(
      text: json['text'] as String?,
      timing: json['timing'] == null
          ? null
          : FhirTiming.fromJson(json['timing'] as Map<String, dynamic>),
      doseAndRate: (json['doseAndRate'] as List<dynamic>?)
          ?.map((e) => FhirDoseAndRate.fromJson(e as Map<String, dynamic>))
          .toList(),
      route: json['route'] == null
          ? null
          : FhirRoute.fromJson(json['route'] as Map<String, dynamic>),
      additionalInstruction: (json['additionalInstruction'] as List<dynamic>?)
          ?.map((e) => FhirCodeableConcept.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FhirDosageInstructionToJson(
        FhirDosageInstruction instance) =>
    <String, dynamic>{
      'text': instance.text,
      'timing': instance.timing,
      'doseAndRate': instance.doseAndRate,
      'route': instance.route,
      'additionalInstruction': instance.additionalInstruction,
    };

FhirTiming _$FhirTimingFromJson(Map<String, dynamic> json) => FhirTiming(
      repeat: json['repeat'] == null
          ? null
          : FhirRepeat.fromJson(json['repeat'] as Map<String, dynamic>),
      boundsDuration: json['boundsDuration'] == null
          ? null
          : FhirBoundsDuration.fromJson(
              json['boundsDuration'] as Map<String, dynamic>),
      when: (json['when'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FhirTimingToJson(FhirTiming instance) =>
    <String, dynamic>{
      'repeat': instance.repeat,
      'boundsDuration': instance.boundsDuration,
      'when': instance.when,
    };

FhirRepeat _$FhirRepeatFromJson(Map<String, dynamic> json) => FhirRepeat(
      frequency: (json['frequency'] as num?)?.toInt(),
      period: (json['period'] as num?)?.toInt(),
      periodUnit: json['periodUnit'] as String?,
      when: (json['when'] as List<dynamic>?)?.map((e) => e as String).toList(),
      duration: (json['duration'] as num?)?.toInt(),
      durationUnit: json['durationUnit'] as String?,
    );

Map<String, dynamic> _$FhirRepeatToJson(FhirRepeat instance) =>
    <String, dynamic>{
      'frequency': instance.frequency,
      'period': instance.period,
      'periodUnit': instance.periodUnit,
      'when': instance.when,
      'duration': instance.duration,
      'durationUnit': instance.durationUnit,
    };

FhirBoundsDuration _$FhirBoundsDurationFromJson(Map<String, dynamic> json) =>
    FhirBoundsDuration(
      value: (json['value'] as num?)?.toInt(),
      unit: json['unit'] as String?,
      system: json['system'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$FhirBoundsDurationToJson(FhirBoundsDuration instance) =>
    <String, dynamic>{
      'value': instance.value,
      'unit': instance.unit,
      'system': instance.system,
      'code': instance.code,
    };

FhirDoseAndRate _$FhirDoseAndRateFromJson(Map<String, dynamic> json) =>
    FhirDoseAndRate(
      type: json['type'] == null
          ? null
          : FhirType.fromJson(json['type'] as Map<String, dynamic>),
      doseQuantity: json['doseQuantity'] == null
          ? null
          : FhirDoseQuantity.fromJson(
              json['doseQuantity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FhirDoseAndRateToJson(FhirDoseAndRate instance) =>
    <String, dynamic>{
      'type': instance.type,
      'doseQuantity': instance.doseQuantity,
    };

FhirType _$FhirTypeFromJson(Map<String, dynamic> json) => FhirType(
      coding: (json['coding'] as List<dynamic>?)
          ?.map((e) => FhirCoding.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FhirTypeToJson(FhirType instance) => <String, dynamic>{
      'coding': instance.coding,
    };

FhirDoseQuantity _$FhirDoseQuantityFromJson(Map<String, dynamic> json) =>
    FhirDoseQuantity(
      value: (json['value'] as num?)?.toInt(),
      unit: json['unit'] as String?,
      system: json['system'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$FhirDoseQuantityToJson(FhirDoseQuantity instance) =>
    <String, dynamic>{
      'value': instance.value,
      'unit': instance.unit,
      'system': instance.system,
      'code': instance.code,
    };

FhirRoute _$FhirRouteFromJson(Map<String, dynamic> json) => FhirRoute(
      coding: (json['coding'] as List<dynamic>?)
          ?.map((e) => FhirCoding.fromJson(e as Map<String, dynamic>))
          .toList(),
      text: json['text'] as String?,
    );

Map<String, dynamic> _$FhirRouteToJson(FhirRoute instance) => <String, dynamic>{
      'coding': instance.coding,
      'text': instance.text,
    };

FhirCodeableConcept _$FhirCodeableConceptFromJson(Map<String, dynamic> json) =>
    FhirCodeableConcept(
      coding: (json['coding'] as List<dynamic>?)
          ?.map((e) => FhirCoding.fromJson(e as Map<String, dynamic>))
          .toList(),
      text: json['text'] as String?,
    );

Map<String, dynamic> _$FhirCodeableConceptToJson(
        FhirCodeableConcept instance) =>
    <String, dynamic>{
      'coding': instance.coding,
      'text': instance.text,
    };

FhirDispenseRequest _$FhirDispenseRequestFromJson(Map<String, dynamic> json) =>
    FhirDispenseRequest(
      numberOfRepeatsAllowed: (json['numberOfRepeatsAllowed'] as num?)?.toInt(),
      expectedSupplyDuration: json['expectedSupplyDuration'] == null
          ? null
          : FhirExpectedSupplyDuration.fromJson(
              json['expectedSupplyDuration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FhirDispenseRequestToJson(
        FhirDispenseRequest instance) =>
    <String, dynamic>{
      'numberOfRepeatsAllowed': instance.numberOfRepeatsAllowed,
      'expectedSupplyDuration': instance.expectedSupplyDuration,
    };

FhirExpectedSupplyDuration _$FhirExpectedSupplyDurationFromJson(
        Map<String, dynamic> json) =>
    FhirExpectedSupplyDuration(
      value: (json['value'] as num?)?.toInt(),
      unit: json['unit'] as String?,
      system: json['system'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$FhirExpectedSupplyDurationToJson(
        FhirExpectedSupplyDuration instance) =>
    <String, dynamic>{
      'value': instance.value,
      'unit': instance.unit,
      'system': instance.system,
      'code': instance.code,
    };
