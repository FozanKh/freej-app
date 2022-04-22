import 'dart:convert';

import 'package:freej/app/events/models/host.dart';
import 'package:freej/core/controllers/enum_controller.dart';

enum EventType { sport, study, helpSession, game, other }
enum EventStatus { new_event, finished, cancelled }
enum EventApplicationStatus { joined, cancelled }

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
  final EventApplicationStatus? applicationStatus;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final EventType type;
  final String name;
  final String description;
  final String? locationUrl;
  final DateTime date;
  final String status;
  final Host host;
  final int campus;
  bool get isJoined => applicationStatus == EventApplicationStatus.joined;

  Event copyWith({
    int? id,
    EventApplicationStatus? applicationStatus,
    DateTime? createdAt,
    DateTime? modifiedAt,
    EventType? type,
    String? name,
    String? description,
    String? locationUrl,
    DateTime? date,
    String? status,
    Host? host,
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
        applicationStatus: json["application_status"] != null
            ? Enums.fromString(EventApplicationStatus.values, json["application_status"])
            : null,
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        type: Enums.fromString(EventType.values, json["type"]) ?? EventType.other,
        name: json["name"],
        description: json["description"],
        locationUrl: json["location_url"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        host: Host.fromMap(json["host"]),
        campus: json["campus"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "application_status": applicationStatus != null ? Enums.valueString(applicationStatus) : null,
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "type": type.name,
        "name": name,
        "description": description,
        "location_url": locationUrl,
        "date": date.toIso8601String(),
        "status": status,
        "host": host.toMap(),
        "campus": campus,
      };
}
