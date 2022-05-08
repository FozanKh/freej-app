import 'dart:convert';

import '../../events/models/person.dart';
import 'user_room.dart';

class UserBuilding {
  UserBuilding({
    required this.id,
    required this.supervisor,
    required this.createdAt,
    required this.modifiedAt,
    required this.name,
    required this.locationUrl,
    required this.whatsAppLink,
    required this.room,
    required this.statistics,
  });

  final int id;
  final Person? supervisor;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String name;
  final String? locationUrl;
  final String? whatsAppLink;
  final UserRoom room;
  final Map<String, dynamic>? statistics;

  UserBuilding copyWith({
    int? id,
    Person? supervisor,
    DateTime? createdAt,
    DateTime? modifiedAt,
    String? name,
    String? locationUrl,
    String? whatsAppLink,
    UserRoom? room,
    Map<String, dynamic>? statistics,
  }) =>
      UserBuilding(
        id: id ?? this.id,
        supervisor: supervisor ?? this.supervisor,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        name: name ?? this.name,
        locationUrl: locationUrl ?? this.locationUrl,
        whatsAppLink: whatsAppLink ?? this.whatsAppLink,
        room: room ?? this.room,
        statistics: statistics ?? this.statistics,
      );

  factory UserBuilding.fromJson(String str) => UserBuilding.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserBuilding.fromMap(Map<String, dynamic> json) => UserBuilding(
        id: json["id"],
        supervisor: json["supervisor"] == null ? null : Person.fromMap(json["supervisor"]),
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        name: json["name"],
        locationUrl: json["location_url"],
        whatsAppLink: json["whatsApp_link"],
        room: UserRoom.fromMap(json["room"]),
        statistics: json["statistics"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "supervisor": supervisor?.toMap(),
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "name": name,
        "location_url": locationUrl,
        "whatsApp_link": whatsAppLink,
        "room": room.toMap(),
        "statistics": statistics
      };
}
