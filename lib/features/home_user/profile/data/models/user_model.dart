class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = (json['data'] is Map)
        ? Map<String, dynamic>.from(json['data'])
        : Map<String, dynamic>.from(json);
    return UserModel(
      id: (data['_id'] ?? data['id'] ?? '').toString(),
      name: (data['name'] ?? data['fullName'] ?? '').toString(),
      email: (data['email'] ?? '').toString(),
      avatarUrl: data['avatarUrl']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'email': email,
    'avatarUrl': avatarUrl,
  };
}
