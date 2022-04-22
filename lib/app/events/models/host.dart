import 'dart:convert';

class Host {
  Host({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  final int id;
  final String? firstName;
  final String? lastName;

  String get name => (firstName ?? '') + " " + (lastName ?? '');

  Host copyWith({
    int? id,
    String? firstName,
    String? lastName,
  }) =>
      Host(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

  factory Host.fromJson(String str) => Host.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Host.fromMap(Map<String, dynamic> json) => Host(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
      };

  @override
  String toString() => name;
}
