import 'package:flutter/material.dart';

import '../../../core/services/api/request_manager.dart';
import 'token.dart';

class AuthToken extends ChangeNotifier {
  AuthToken({this.refresh, this.access});

  Token? refresh;
  Token? access;

  AuthToken copyWith({Token? refresh, Token? access}) => AuthToken(
        refresh: refresh ?? this.refresh,
        access: access ?? this.access,
      );

  factory AuthToken.fromMap(Map<String, dynamic> json) => AuthToken(
        refresh: Token.fromMap(json["refresh"]),
        access: Token.fromMap(json["access"]),
      );

  factory AuthToken.fromTokens({required Token access, required Token refresh}) => AuthToken(
        refresh: refresh,
        access: access,
      );

  Map<String, dynamic> toMap() => {
        "refresh": refresh?.toMap(),
        "access": access?.toMap(),
      };

  bool get isActive {
    return (refresh?.isActive ?? false);
  }

  bool get needsRefresh {
    return (refresh?.isActive ?? false) && !(access?.isActive ?? false);
  }

  void updateFromToken(AuthToken token, {notify = true}) {
    access = token.access;
    refresh = token.refresh;
    RequestManger.authToken = this;
    if (notify) notifyListeners();
    return;
  }

  void remove({bool notify = true}) {
    access = null;
    refresh = null;
    if (notify) notifyListeners();
    return;
  }

  @override
  String toString() => 'AuthTokens(refresh: $refresh, access: $access)';

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
