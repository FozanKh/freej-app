import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../core/exports/core.dart';

enum NotificationType { individual, group, competition, corporate, announcement }

class Notifications {
  Notifications({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  Notifications copyWith({
    String? title,
    String? body,
  }) =>
      Notifications(
        title: title ?? this.title,
        body: body ?? this.body,
      );

  factory Notifications.fromJson(String str) => Notifications.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Notifications.fromMap(Map<String, dynamic> json) => Notifications(
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "body": body,
      };
}

extension NotificationTypeExt on NotificationType {
  IconData get icon => _notificationTypeIcon[this] ?? FzIcons.bell;
  String get string => Enums.valueString(this);
}

const Map<NotificationType, IconData> _notificationTypeIcon = {
  NotificationType.individual: FzIcons.bell,
};
