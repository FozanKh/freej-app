import 'dart:convert';

import '../../../core/controllers/enum_controller.dart';
import 'announcement.dart';

class CommercialAnnouncement implements Announcement {
  CommercialAnnouncement({
    required this.id,
    required this.createdAt,
    required this.modifiedAt,
    required this.type,
    required this.title,
    required this.body,
    required this.advertiserName,
    required this.link,
    required this.sender,
    required this.campus,
    required this.image,
  });

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime modifiedAt;
  @override
  final AnnouncementType type;
  @override
  final String title;
  @override
  final String body;
  @override
  final int sender;
  final String advertiserName;
  final String? link;
  final String? image;
  final int campus;

  @override
  CommercialAnnouncement copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? modifiedAt,
    AnnouncementType? type,
    String? title,
    String? body,
    String? advertiserName,
    String? link,
    String? image,
    int? sender,
    int? campus,
  }) =>
      CommercialAnnouncement(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        type: type ?? this.type,
        title: title ?? this.title,
        body: body ?? this.body,
        advertiserName: advertiserName ?? this.advertiserName,
        link: link ?? this.link,
        image: image ?? this.image,
        sender: sender ?? this.sender,
        campus: campus ?? this.campus,
      );

  factory CommercialAnnouncement.fromJson(String str) => CommercialAnnouncement.fromMap(json.decode(str));

  @override
  String toJson() => json.encode(toMap());

  factory CommercialAnnouncement.fromMap(Map<String, dynamic> json) => CommercialAnnouncement(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        type: Enums.fromString(AnnouncementType.values, json["type"]) ?? AnnouncementType.building,
        title: json["title"],
        body: json["body"],
        advertiserName: json["advertiser_name"],
        link: json["link"],
        image: json["image"],
        sender: json["sender"],
        campus: json["campus"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "type": Enums.valueString(type),
        "title": title,
        "body": body,
        "advertiser_name": advertiserName,
        "link": link,
        "image": image,
        "sender": sender,
        "campus": campus,
      };
}
