import 'dart:convert';

class User {
  int? id;
  String? name;
  int? userId;

  User({
    this.id,
    this.name,
    this.userId,
  });

  User copyWith({
    int? id,
    String? name,
    int? userId,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (userId != null) {
      result.addAll({'userId': userId});
    }

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt(),
      name: map['name'],
      userId: map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id && other.name == name && other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ userId.hashCode;
  }
}
