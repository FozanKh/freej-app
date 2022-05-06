import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freej/core/constants/colors.dart';
import 'package:freej/core/controllers/enum_controller.dart';
import 'package:provider/provider.dart';

import '../../auth/models/user.dart';
import '../../events/models/person.dart';

enum PostType { offer, request, post }
//! DON'T TOUCH THIS! vv
enum PostApplicationStatus { pending, accepted, completed, rejected, cancelled, unknown }
//! DON'T TOUCH THIS! ^^

class Post {
  Post({
    required this.id,
    required this.owner,
    required this.applicationStatus,
    required this.reviews,
    required this.images,
    required this.applications,
    required this.createdAt,
    required this.modifiedAt,
    required this.type,
    required this.title,
    required this.description,
    required this.isActive,
    required this.campus,
  });

  final int id;
  final Person owner;
  final PostApplicationStatus applicationStatus;
  final List<_PostReview>? reviews;
  final List<String>? images;
  final List<PostApplication>? applications;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final PostType type;
  final String title;
  final String description;
  final bool isActive;
  final int campus;

  PostApplication? myApplication(BuildContext context) {
    return applications?.firstWhereOrNull((application) => application.beneficiary.id == context.read<User>().id);
  }

  Post copyWith({
    int? id,
    Person? owner,
    PostApplicationStatus? applicationStatus,
    List<_PostReview>? reviews,
    List<String>? images,
    List<PostApplication>? applications,
    DateTime? createdAt,
    DateTime? modifiedAt,
    PostType? type,
    String? title,
    String? description,
    bool? isActive,
    int? campus,
  }) =>
      Post(
        id: id ?? this.id,
        owner: owner ?? this.owner,
        applicationStatus: applicationStatus ?? this.applicationStatus,
        reviews: reviews ?? this.reviews,
        images: images ?? this.images,
        applications: applications ?? this.applications,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        type: type ?? this.type,
        title: title ?? this.title,
        description: description ?? this.description,
        isActive: isActive ?? this.isActive,
        campus: campus ?? this.campus,
      );

  factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        id: json["id"],
        owner: Person.fromMap(json["owner"]),
        applicationStatus:
            Enums.fromString(PostApplicationStatus.values, json["application_status"]) ?? PostApplicationStatus.unknown,
        reviews: List<_PostReview>.from(json["reviews"].map((x) => _PostReview.fromMap(x))),
        images: List<String>.from(json["images"]),
        applications: List<PostApplication>.from(json["applications"].map((x) => PostApplication.fromMap(x))),
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        type: Enums.fromString(PostType.values, json["type"]) ?? PostType.post,
        title: json["title"],
        description: json["description"],
        isActive: json["is_active"],
        campus: json["campus"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "owner": owner.toMap(),
        "reviews": reviews != null ? List<dynamic>.from(reviews!.map((x) => x.toMap())) : null,
        "application_status": Enums.valueString(applicationStatus),
        "images": images,
        "applications": applications != null ? List<dynamic>.from(applications!.map((x) => x.toMap())) : null,
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "type": type.name,
        "title": title,
        "description": description,
        "is_active": isActive,
        "campus": campus,
      };
}

class PostApplication {
  PostApplication({
    required this.id,
    required this.beneficiary,
    required this.createdAt,
    required this.modifiedAt,
    required this.status,
    required this.statusUpdatedAt,
    required this.description,
    required this.post,
  });

  final int id;
  final Person beneficiary;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final PostApplicationStatus status;
  final DateTime statusUpdatedAt;
  final String description;
  final int post;

  Color get statusColor => [kGrey, kGreen, kBlue, kRed2, kRed2, kGrey][status.index];

  PostApplication copyWith({
    int? id,
    Person? beneficiary,
    DateTime? createdAt,
    DateTime? modifiedAt,
    PostApplicationStatus? status,
    DateTime? statusUpdatedAt,
    String? description,
    int? post,
  }) =>
      PostApplication(
        id: id ?? this.id,
        beneficiary: beneficiary ?? this.beneficiary,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        status: status ?? this.status,
        statusUpdatedAt: statusUpdatedAt ?? this.statusUpdatedAt,
        description: description ?? this.description,
        post: post ?? this.post,
      );

  factory PostApplication.fromJson(String str) => PostApplication.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostApplication.fromMap(Map<String, dynamic> json) => PostApplication(
        id: json["id"],
        beneficiary: Person.fromMap(json["beneficiary"]),
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        status: Enums.fromString(PostApplicationStatus.values, json["status"]) ?? PostApplicationStatus.unknown,
        statusUpdatedAt: DateTime.parse(json["status_updated_at"]),
        description: json["description"],
        post: json["post"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "beneficiary": beneficiary.toMap(),
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "status": Enums.valueString(status),
        "status_updated_at": statusUpdatedAt.toIso8601String(),
        "description": description,
        "post": post,
      };
}

class _PostReview {
  _PostReview({
    required this.id,
    required this.createdAt,
    required this.modifiedAt,
    required this.rating,
    required this.comment,
    required this.post,
    required this.reviewer,
  });

  final int id;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final double rating;
  final String comment;
  final int post;
  final int reviewer;

  String get stars {
    int fullStarts = rating.toInt();
    int emptyStarts = max(0, 5 - fullStarts);
    String starts = ('★' * fullStarts.toInt());
    starts += ('☆' * emptyStarts.toInt());
    return starts.substring(0, 5);
  }

  _PostReview copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? modifiedAt,
    double? rating,
    String? comment,
    int? post,
    int? reviewer,
  }) =>
      _PostReview(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        rating: rating ?? this.rating,
        comment: comment ?? this.comment,
        post: post ?? this.post,
        reviewer: reviewer ?? this.reviewer,
      );

  factory _PostReview.fromJson(String str) => _PostReview.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory _PostReview.fromMap(Map<String, dynamic> json) => _PostReview(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        rating: json["rating"]?.toDouble(),
        comment: json["comment"],
        post: json["post"],
        reviewer: json["reviewer"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "rating": rating,
        "comment": comment,
        "post": post,
        "reviewer": reviewer,
      };
}
