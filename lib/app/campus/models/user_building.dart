import 'dart:convert';

import 'user_room.dart';

class UserBuilding {
  UserBuilding({
    required this.id,
    required this.createdAt,
    required this.modifiedAt,
    required this.name,
    required this.whatsAppLink,
    required this.room,
  });

  final int id;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String name;
  final String? whatsAppLink;
  final UserRoom room;

  UserBuilding copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? modifiedAt,
    String? name,
    String? whatsAppLink,
    UserRoom? room,
  }) =>
      UserBuilding(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        name: name ?? this.name,
        whatsAppLink: whatsAppLink ?? this.whatsAppLink,
        room: room ?? this.room,
      );

  factory UserBuilding.fromJson(String str) => UserBuilding.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserBuilding.fromMap(Map<String, dynamic> json) => UserBuilding(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        name: json["name"],
        whatsAppLink: json["whatsApp_link"],
        room: UserRoom.fromMap(json["room"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "name": name,
        "whatsApp_link": whatsAppLink,
        "room": room.toMap(),
      };
}
