import 'dart:convert';

class CommercialAnnouncement {
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
  });

  final int id;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String type;
  final String title;
  final String body;
  final String advertiserName;
  final String link;
  final int sender;
  final int campus;

  CommercialAnnouncement copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? modifiedAt,
    String? type,
    String? title,
    String? body,
    String? advertiserName,
    String? link,
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
        sender: sender ?? this.sender,
        campus: campus ?? this.campus,
      );

  factory CommercialAnnouncement.fromJson(String str) => CommercialAnnouncement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommercialAnnouncement.fromMap(Map<String, dynamic> json) => CommercialAnnouncement(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        type: json["type"],
        title: json["title"],
        body: json["body"],
        advertiserName: json["advertiser_name"],
        link: json["link"],
        sender: json["sender"],
        campus: json["campus"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "type": type,
        "title": title,
        "body": body,
        "advertiser_name": advertiserName,
        "link": link,
        "sender": sender,
        "campus": campus,
      };
}
