class ApiError {
  ApiError({
    required this.code,
    required this.messages,
  });

  final int code;
  final List<String> messages;

  factory ApiError.fromMap(Map<String, dynamic> json) => ApiError(
        code: json["code"],
        messages: List<String>.from(json["messages"].map((x) => x.toString())),
      );

  @override
  String toString() => 'ApiError(code: $code\n messages: $messages)';
}
