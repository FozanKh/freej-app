import 'dart:convert';

class Notifications implements Comparable {
  Notifications({
    required this.id,
    required this.createdAt,
    required this.modifiedAt,
    required this.title,
    required this.body,
    required this.type,
    required this.instanceId,
  });

  final int id;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String title;
  final String body;
  final String? type;
  final int? instanceId;

  Notifications copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? modifiedAt,
    String? title,
    String? body,
    String? type,
    int? instanceId,
  }) =>
      Notifications(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        title: title ?? this.title,
        body: body ?? this.body,
        type: type ?? this.type,
        instanceId: instanceId ?? this.instanceId,
      );

  factory Notifications.fromJson(String str) => Notifications.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Notifications.fromMap(Map<String, dynamic> json) => Notifications(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        title: json["title"],
        body: json["body"],
        type: json["type"],
        instanceId: json["instance_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "title": title,
        "body": body,
        "type": type,
        "instance_id": instanceId,
      };

  @override
  int compareTo(other) {
    return -createdAt.compareTo(other.createdAt);
  }
}

// extension NotificationTypeExt on NotificationType {
//   IconData get icon => _notificationTypeIcon[this] ?? FzIcons.bell;
//   String get string => Enums.valueString(this);
// }

// const Map<NotificationType, IconData> _notificationTypeIcon = {
//   NotificationType.individual: FzIcons.bell,
// };
