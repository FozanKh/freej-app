class Campus {
  Campus({
    required this.id,
    required this.createdAt,
    required this.modifiedAt,
    required this.nameAr,
    required this.nameEn,
    required this.emailDomain,
  });

  final int id;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String nameAr;
  final String nameEn;
  final String emailDomain;

  Campus copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? modifiedAt,
    String? nameAr,
    String? nameEn,
    String? emailDomain,
  }) =>
      Campus(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
        emailDomain: emailDomain ?? this.emailDomain,
      );

  factory Campus.fromMap(Map<String, dynamic> json) => Campus(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        modifiedAt: DateTime.parse(json["modified_at"]),
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        emailDomain: json["email_domain"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "modified_at": modifiedAt.toIso8601String(),
        "name_ar": nameAr,
        "name_en": nameEn,
        "email_domain": emailDomain,
      };
}
