import 'dart:convert';

class Account {
  Account({
    required this.username,
    required this.mobileNumber,
    required this.firstName,
    required this.lastName,
  });

  final String username;
  final String? mobileNumber;
  final String? firstName;
  final String? lastName;

  Account copyWith({
    String? username,
    String? mobileNumber,
    String? firstName,
    String? lastName,
  }) =>
      Account(
        username: username ?? this.username,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

  factory Account.fromJson(String str) => Account.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Account.fromMap(Map<String, dynamic> json) => Account(
        username: json["username"],
        mobileNumber: json["mobile_number"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toMap() => {
        "username": username,
        "mobile_number": mobileNumber,
        "first_name": firstName,
        "last_name": lastName,
      };
}
