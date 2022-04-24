import 'dart:convert';

import 'package:freej/core/controllers/enum_controller.dart';

enum AnnouncementType { building, campus, advertisement }

class Announcement {
  static final sample = Announcement.fromMap(
    {
      "id": 2,
      "created_at": "2022-03-27T18:22:24.101681Z",
      "modified_at": "2022-03-27T18:22:24.101716Z",
      "type": "campus",
      "title": "First campus announcement",
      "body": "This is the first campus announcement",
      "sender": 1
    },
  );
  Announcement({
    required this.id,
    required this.createdAt,
    required this.modifiedAt,
    required this.type,
    required this.title,
    required this.body,
    required this.sender,
  });

  final int id;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final AnnouncementType type;
  final String title;
  final String body;
  final int sender;

  Announcement copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? modifiedAt,
    AnnouncementType? type,
    String? title,
    String? body,
    int? sender,
  }) =>
      Announcement(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        type: type ?? this.type,
        title: title ?? this.title,
        body: body ?? this.body,
        sender: sender ?? this.sender,
      );

  factory Announcement.fromJson(String str) => Announcement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Announcement.fromMap(Map<String, dynamic> json) => Announcement(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        type: Enums.fromString(AnnouncementType.values, json["type"]) ?? AnnouncementType.building,
        title: json["title"],
        body: json["body"],
        sender: json["sender"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "type": Enums.valueString(type),
        "title": title,
        "body": body,
        "sender": sender,
      };
}
