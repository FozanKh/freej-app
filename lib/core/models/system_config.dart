import 'dart:convert';

class SystemConfig {
  SystemConfig({
    required this.key,
    required this.value,
    required this.description,
    required this.tag,
  });

  final String? key;
  final String? value;
  final String? description;
  final String? tag;

  SystemConfig copyWith({
    String? key,
    String? value,
    String? description,
    String? tag,
  }) =>
      SystemConfig(
        key: key ?? this.key,
        value: value ?? this.value,
        description: description ?? this.description,
        tag: tag ?? this.tag,
      );

  factory SystemConfig.fromJson(String str) => SystemConfig.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SystemConfig.fromMap(Map<String, dynamic> json) => SystemConfig(
        key: json["key"],
        value: json["value"],
        description: json["description"],
        tag: json["tag"],
      );

  SystemConfig fromMap(Map<String, dynamic> json) => SystemConfig(
        key: json["key"],
        value: json["value"],
        description: json["description"],
        tag: json["tag"],
      );

  Map<String, dynamic> toMap() => {
        "key": key,
        "value": value,
        "description": description,
        "tag": tag,
      };

  @override
  String toString() {
    return 'SystemConfig(key: $key, value: $value, description: $description, tag: $tag)';
  }
}
