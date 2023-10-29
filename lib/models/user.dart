import 'dart:convert';

class LocalUser {
  final String id;
  final String name;
  final String photoURL;
  final String email;
  LocalUser({
    required this.id,
    required this.name,
    required this.photoURL,
    required this.email,
  });

  LocalUser copyWith({
    String? id,
    String? name,
    String? photoURL,
    String? email,
  }) {
    return LocalUser(
      id: id ?? this.id,
      name: name ?? this.name,
      photoURL: photoURL ?? this.photoURL,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'photoURL': photoURL});
    result.addAll({'email': email});
  
    return result;
  }

  factory LocalUser.fromMap(Map<String, dynamic> map) {
    return LocalUser(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      photoURL: map['photoURL'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalUser.fromJson(String source) => LocalUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocalUser(id: $id, name: $name, photoURL: $photoURL, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LocalUser &&
      other.id == id &&
      other.name == name &&
      other.photoURL == photoURL &&
      other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      photoURL.hashCode ^
      email.hashCode;
  }
}
