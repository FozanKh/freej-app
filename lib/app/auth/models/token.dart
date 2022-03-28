import 'package:jwt_decode/jwt_decode.dart';

import '../../../core/exports/core.dart';

enum TokenType { refresh, access }

class Token {
  Token({required this.token}) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    exp = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
    type = Enums.fromString(TokenType.values, payload['token_type'])!;
  }

  final String token;
  late final DateTime exp;
  late final TokenType type;

  Token copyWith({String? token}) => Token(token: token ?? this.token);

  factory Token.fromMap(String token) => Token(token: token);

  String toMap() => token;

  @override
  String toString() => 'Token(type: $type, exp: $exp, token: $token)';

  bool get isActive => (exp.millisecondsSinceEpoch) > DateTime.now().millisecondsSinceEpoch;
}
