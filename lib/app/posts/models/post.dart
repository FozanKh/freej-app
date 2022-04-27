import 'dart:convert';

import 'package:freej/core/controllers/enum_controller.dart';

enum PostType { offer, request, post }

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
  final _PostPerson owner;
  final String? applicationStatus;
  final List<_PostReview>? reviews;
  final List<_PostImage>? images;
  final List<_PostApplication>? applications;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final PostType type;
  final String title;
  final String description;
  final bool isActive;
  final int campus;

  Post copyWith({
    int? id,
    _PostPerson? owner,
    String? applicationStatus,
    List<_PostReview>? reviews,
    List<_PostImage>? images,
    List<_PostApplication>? applications,
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
        owner: _PostPerson.fromMap(json["owner"]),
        applicationStatus: json["application_status"],
        reviews: List<_PostReview>.from(json["reviews"].map((x) => _PostReview.fromMap(x))),
        images: List<_PostImage>.from(json["images"].map((x) => _PostImage.fromMap(x))),
        applications: List<_PostApplication>.from(json["applications"].map((x) => _PostApplication.fromMap(x))),
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
        "application_status": applicationStatus,
        "reviews": reviews != null ? List<dynamic>.from(reviews!.map((x) => x.toMap())) : null,
        "images": images != null ? List<dynamic>.from(images!.map((x) => x.toMap())) : null,
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

class _PostApplication {
  _PostApplication({
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
  final _PostPerson beneficiary;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String status;
  final DateTime statusUpdatedAt;
  final String description;
  final int post;

  _PostApplication copyWith({
    int? id,
    _PostPerson? beneficiary,
    DateTime? createdAt,
    DateTime? modifiedAt,
    String? status,
    DateTime? statusUpdatedAt,
    String? description,
    int? post,
  }) =>
      _PostApplication(
        id: id ?? this.id,
        beneficiary: beneficiary ?? this.beneficiary,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        status: status ?? this.status,
        statusUpdatedAt: statusUpdatedAt ?? this.statusUpdatedAt,
        description: description ?? this.description,
        post: post ?? this.post,
      );

  factory _PostApplication.fromJson(String str) => _PostApplication.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory _PostApplication.fromMap(Map<String, dynamic> json) => _PostApplication(
        id: json["id"],
        beneficiary: _PostPerson.fromMap(json["beneficiary"]),
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        status: json["status"],
        statusUpdatedAt: DateTime.parse(json["status_updated_at"]),
        description: json["description"],
        post: json["post"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "beneficiary": beneficiary.toMap(),
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "status": status,
        "status_updated_at": statusUpdatedAt.toIso8601String(),
        "description": description,
        "post": post,
      };
}

class _PostPerson {
  _PostPerson({
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.id,
  });

  final String firstName;
  final String lastName;
  final String mobileNumber;
  final int id;

  _PostPerson copyWith({
    String? firstName,
    String? lastName,
    String? mobileNumber,
    int? id,
  }) =>
      _PostPerson(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        id: id ?? this.id,
      );

  factory _PostPerson.fromJson(String str) => _PostPerson.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory _PostPerson.fromMap(Map<String, dynamic> json) => _PostPerson(
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobileNumber: json["mobile_number"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "first_name": firstName,
        "last_name": lastName,
        "mobile_number": mobileNumber,
        "id": id == null ? null : id,
      };
}

class _PostImage {
  _PostImage({
    required this.image,
  });

  final String image;

  _PostImage copyWith({
    String? image,
  }) =>
      _PostImage(
        image: image ?? this.image,
      );

  factory _PostImage.fromJson(String str) => _PostImage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory _PostImage.fromMap(Map<String, dynamic> json) => _PostImage(
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "image": image,
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
