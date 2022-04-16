import 'dart:convert';

import 'package:freej/core/controllers/enum_controller.dart';

enum EventType { sport, study, helpSession, game, other }

class Event {
  Event({
    required this.id,
    required this.applicationStatus,
    required this.createdAt,
    required this.modifiedAt,
    required this.type,
    required this.name,
    required this.description,
    required this.locationUrl,
    required this.date,
    required this.status,
    required this.host,
    required this.campus,
  });

  final int id;
  final String? applicationStatus;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final EventType type;
  final String name;
  final String description;
  final String? locationUrl;
  final DateTime date;
  final String status;
  final int host;
  final int campus;

  Event copyWith({
    int? id,
    String? applicationStatus,
    DateTime? createdAt,
    DateTime? modifiedAt,
    EventType? type,
    String? name,
    String? description,
    String? locationUrl,
    DateTime? date,
    String? status,
    int? host,
    int? campus,
  }) =>
      Event(
        id: id ?? this.id,
        applicationStatus: applicationStatus ?? this.applicationStatus,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        type: type ?? this.type,
        name: name ?? this.name,
        description: description ?? this.description,
        locationUrl: locationUrl ?? this.locationUrl,
        date: date ?? this.date,
        status: status ?? this.status,
        host: host ?? this.host,
        campus: campus ?? this.campus,
      );

  factory Event.fromJson(String str) => Event.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Event.fromMap(Map<String, dynamic> json) => Event(
        id: json["id"],
        applicationStatus: json["application_status"],
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        type: Enums.fromString(EventType.values, json["type"]) ?? EventType.other,
        name: json["name"],
        description: json["description"],
        locationUrl: json["location_url"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        host: json["host"],
        campus: json["campus"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "application_status": applicationStatus,
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "type": type.name,
        "name": name,
        "description": description,
        "location_url": locationUrl,
        "date": date.toIso8601String(),
        "status": status,
        "host": host,
        "campus": campus,
      };
}
