import 'dart:convert';

import 'package:freej/core/controllers/enum_controller.dart';

enum PostType { offer, request, post }

class Post {
  Post({
    required this.id,
    required this.owner,
    required this.createdAt,
    required this.modifiedAt,
    required this.type,
    required this.title,
    required this.description,
    required this.isActive,
    required this.campus,
  });

  final int id;
  final _Owner owner;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final PostType type;
  final String title;
  final String description;
  final bool isActive;
  final int campus;

  Post copyWith({
    int? id,
    _Owner? owner,
    DateTime? createdAt,
    DateTime? modifiedAt,
    PostType? type,
    String? title,
    String? description,
    bool? isActive,
    int? campus,
  }) =>
      Post(
        id: id ?? this.id,
        owner: owner ?? this.owner,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        type: type ?? this.type,
        title: title ?? this.title,
        description: description ?? this.description,
        isActive: isActive ?? this.isActive,
        campus: campus ?? this.campus,
      );

  factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        id: json["id"],
        owner: _Owner.fromMap(json["owner"]),
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        type: Enums.fromString(PostType.values, json["type"]) ?? PostType.post,
        title: json["title"],
        description: json["description"],
        isActive: json["is_active"],
        campus: json["campus"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "owner": owner.toMap(),
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "type": type,
        "title": title,
        "description": description,
        "is_active": isActive,
        "campus": campus,
      };
}

class _Owner {
  _Owner({
    required this.firstName,
    required this.lastName,
  });

  final String firstName;
  final String lastName;

  _Owner copyWith({
    String? firstName,
    String? lastName,
  }) =>
      _Owner(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

  factory _Owner.fromJson(String str) => _Owner.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory _Owner.fromMap(Map<String, dynamic> json) => _Owner(
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toMap() => {
        "first_name": firstName,
        "last_name": lastName,
      };
}
