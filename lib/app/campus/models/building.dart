import 'dart:convert';

import 'package:freej/core/util/extension.dart';

// import '../../auth/models/user.dart';
import 'room.dart';

class Building {
  Building({
    required this.id,
    required this.rooms,
    required this.createdAt,
    required this.modifiedAt,
    required this.name,
    required this.whatsAppLink,
    required this.campus,
    // required this.supervisor,
  });

  final int id;
  final List<Room> rooms;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String name;
  final String? whatsAppLink;
  final int campus;
  // final User? supervisor;

  Building copyWith({
    int? id,
    List<Room>? rooms,
    DateTime? createdAt,
    DateTime? modifiedAt,
    String? name,
    String? whatsAppLink,
    int? campus,
    // User? supervisor,
  }) =>
      Building(
        id: id ?? this.id,
        rooms: rooms ?? this.rooms,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        name: name ?? this.name,
        whatsAppLink: whatsAppLink ?? this.whatsAppLink,
        campus: campus ?? this.campus,
        // // // supervisor: supervisor ?? this.supervisor,
      );

  factory Building.fromJson(String str) => Building.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Building.fromMap(Map<String, dynamic> json) => Building(
        id: json["id"],
        rooms: List<Room>.from(json["rooms"].map((x) => Room.fromMap(x))),
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        name: json["name"],
        whatsAppLink: json["whatsApp_link"],
        campus: json["campus"],
        // // // supervisor: json["supervisor"] != null ? User.fromMap(json["supervisor"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "rooms": List<dynamic>.from(rooms.map((x) => x.toMap())),
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "name": name,
        "whatsApp_link": whatsAppLink,
        "campus": campus,
        // // "supervisor": supervisor,
      };

  @override
  String toString() {
    return toMap().prettyJson;
  }
}
