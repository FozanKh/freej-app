import 'dart:convert';

class UserRoom {
  UserRoom({
    required this.id,
    required this.createdAt,
    required this.modifiedAt,
    required this.name,
  });

  final int id;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String name;

  UserRoom copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? modifiedAt,
    String? name,
  }) =>
      UserRoom(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        name: name ?? this.name,
      );

  factory UserRoom.fromJson(String str) => UserRoom.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserRoom.fromMap(Map<String, dynamic> json) => UserRoom(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "name": name,
      };
}
