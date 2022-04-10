import 'dart:convert';

import 'package:flutter/material.dart';

import '../../campus/models/campus.dart';
import 'account.dart';

class User extends ChangeNotifier {
  User({
    this.id,
    this.campusDetails,
    this.createdAt,
    this.modifiedAt,
    this.isSupervisor,
    this.room,
    this.account,
  });

  int? id;
  Campus? campusDetails;
  DateTime? createdAt;
  DateTime? modifiedAt;
  bool? isSupervisor;
  int? room;
  Account? account;

  String get name {
    String name = account?.firstName ?? '';
    name += (account?.lastName?.isNotEmpty ?? false) ? ' ${account?.lastName}' : '';
    return name.trim().isEmpty ? 'Guest' : name;
  }

  String? get email => account?.username;
  bool get isLoggedIn => id != null;

  User copyWith({
    int? id,
    Campus? campusDetails,
    DateTime? createdAt,
    DateTime? modifiedAt,
    bool? isSupervisor,
    int? room,
    Account? account,
  }) =>
      User(
        id: id ?? this.id,
        campusDetails: campusDetails ?? this.campusDetails,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        isSupervisor: isSupervisor ?? this.isSupervisor,
        room: room ?? this.room,
        account: account ?? this.account,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        campusDetails: Campus.fromMap(json["campus_details"]),
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        isSupervisor: json["is_supervisor"],
        room: json["room"],
        account: Account.fromMap(json["account"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "campus_details": campusDetails?.toMap(),
        "created_at": createdAt?.toIso8601String(),
        "modified_at": modifiedAt?.toIso8601String(),
        "is_supervisor": isSupervisor,
        "room": room,
        "account": account?.toMap(),
      };

  void updateFromUser(User user, {notify = true, switchTab = true}) {
    id = user.id;
    campusDetails = user.campusDetails;
    createdAt = user.createdAt;
    modifiedAt = user.modifiedAt;
    isSupervisor = user.isSupervisor;
    room = user.room;
    account = user.account;
    if (notify) notifyListeners();
  }

  void remove({notify = true}) {
    updateFromUser(User(), notify: notify);
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}