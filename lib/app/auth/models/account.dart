import 'dart:convert';

class Account {
  Account({
    required this.username,
    required this.mobileNumber,
    required this.name,
  });

  final String username;
  final String? mobileNumber;
  final String? name;

  Account copyWith({
    String? username,
    String? mobileNumber,
    String? name,
    String? lastName,
  }) =>
      Account(
        username: username ?? this.username,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        name: name ?? this.name,
      );

  factory Account.fromJson(String str) => Account.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Account.fromMap(Map<String, dynamic> json) => Account(
        username: json["username"],
        mobileNumber: json["mobile_number"],
        name: json["first_name"],
      );

  Map<String, dynamic> toMap() => {
        "username": username,
        "mobile_number": mobileNumber,
        "first_name": name,
      };
}
