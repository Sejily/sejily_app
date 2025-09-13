class EmergencyContact {
  final String id;
  final String name;
  final String phoneNumber;
  final String relation;

  EmergencyContact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.relation,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      relation: json['relation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'phoneNumber': phoneNumber, 'relation': relation};
  }
}
