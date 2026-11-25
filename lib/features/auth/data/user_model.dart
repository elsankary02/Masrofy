class UserModel {
  final String id;
  final String name;
  final String email;
  final String photoPath;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.photoPath,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String? ?? 'local_user',
      name: map['name'] as String? ?? 'مستخدم مصروفي',
      email: map['email'] as String? ?? '',
      photoPath: map['photoPath'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'photoPath': photoPath};
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? photoPath,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoPath: photoPath ?? this.photoPath,
    );
  }
}
