import 'dart:convert';

import '../../../core/controllers/enum_controller.dart';

enum MaintenanceIssueType { halls, rooms, bathrooms, other }

class MaintenanceIssue implements Comparable {
  MaintenanceIssue({
    required this.id,
    required this.createdAt,
    required this.modifiedAt,
    required this.type,
    required this.description,
    required this.reportedFixed,
    required this.status,
    required this.reportedBy,
    required this.building,
  });

  final int id;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final MaintenanceIssueType type;
  final String description;
  final int reportedFixed;
  final String status;
  final int reportedBy;
  final int building;

  MaintenanceIssue copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? modifiedAt,
    MaintenanceIssueType? type,
    String? description,
    int? reportedFixed,
    String? status,
    int? reportedBy,
    int? building,
  }) =>
      MaintenanceIssue(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        type: type ?? this.type,
        description: description ?? this.description,
        reportedFixed: reportedFixed ?? this.reportedFixed,
        status: status ?? this.status,
        reportedBy: reportedBy ?? this.reportedBy,
        building: building ?? this.building,
      );

  factory MaintenanceIssue.fromJson(String str) => MaintenanceIssue.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MaintenanceIssue.fromMap(Map<String, dynamic> json) => MaintenanceIssue(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        type: Enums.fromString(MaintenanceIssueType.values, json["type"]) ?? MaintenanceIssueType.other,
        description: json["description"],
        reportedFixed: json["reported_fixed"],
        status: json["status"],
        reportedBy: json["reported_by"],
        building: json["building"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "type": type.name,
        "description": description,
        "reported_fixed": reportedFixed,
        "status": status,
        "reported_by": reportedBy,
        "building": building,
      };

  @override
  int compareTo(other) {
    return -createdAt.compareTo(other.createdAt);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MaintenanceIssue &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.modifiedAt == modifiedAt &&
        other.type == type &&
        other.description == description &&
        other.reportedFixed == reportedFixed &&
        other.status == status &&
        other.reportedBy == reportedBy &&
        other.building == building;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        modifiedAt.hashCode ^
        type.hashCode ^
        description.hashCode ^
        reportedFixed.hashCode ^
        status.hashCode ^
        reportedBy.hashCode ^
        building.hashCode;
  }
}
