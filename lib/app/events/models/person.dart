import 'dart:convert';

import 'dart:math';

class Person {
  Person({
    required this.firstName,
    required this.lastName,
    required this.room,
    required this.building,
    required this.mobileNumber,
    required this.id,
    required this.numberOfRaters,
    required this.rating,
  });

  final String? firstName;
  final String? lastName;
  final String? room;
  final String? building;
  final String? mobileNumber;
  final int id;
  final int? numberOfRaters;
  final double? rating;

  String get stars {
    if (rating == null) return '';
    int fullStarts = rating!.toInt();
    int emptyStarts = max(0, 5 - fullStarts);
    String starts = ('★' * fullStarts.toInt());
    starts += ('☆' * emptyStarts.toInt());
    return starts.substring(0, 5);
  }

  Person copyWith({
    String? firstName,
    String? lastName,
    String? mobileNumber,
    String? room,
    String? building,
    int? id,
    int? numberOfRaters,
    double? rating,
  }) =>
      Person(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        id: id ?? this.id,
        numberOfRaters: numberOfRaters ?? this.numberOfRaters,
        rating: rating ?? this.rating,
        room: room ?? this.room,
        building: building ?? this.building,
      );

  factory Person.fromJson(String str) => Person.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Person.fromMap(Map<String, dynamic> json) => Person(
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobileNumber: json["mobile_number"],
        id: json["id"],
        numberOfRaters: json["num_of_raters"],
        rating: json["rating"],
        room: json["room_name"],
        building: json["building_name"],
      );

  Map<String, dynamic> toMap() => {
        "first_name": firstName,
        "last_name": lastName,
        "mobile_number": mobileNumber,
        "id": id,
        "num_of_raters": numberOfRaters,
        "rating": rating,
        "room_name": room,
        "building_name": building,
      };
}
