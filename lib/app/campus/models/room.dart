class Room {
  Room({
    required this.id,
    required this.createdAt,
    required this.modifiedAt,
    required this.name,
    required this.building,
  });

  final int id;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String name;
  final int building;

  Room copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? modifiedAt,
    String? name,
    int? building,
  }) =>
      Room(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        name: name ?? this.name,
        building: building ?? this.building,
      );

  factory Room.fromMap(Map<String, dynamic> json) => Room(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        name: json["name"],
        building: json["building"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "name": name,
        "building": building,
      };
}
