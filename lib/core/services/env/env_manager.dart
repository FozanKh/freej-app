import 'dart:developer';

import '../api/request_manager.dart';

enum Environment { DEV, UAT, PROD }

class EnvironmentManager {
  EnvironmentManager._();

  static Environment? env;

  static init() {
    const currEnv = String.fromEnvironment('ENV');
    log(currEnv, name: "EnvironmentManager/init");
    switch (currEnv) {
      case "DEV":
        env = Environment.DEV;
        RequestManger.baseUrl = const String.fromEnvironment('api-base-url');
        break;
      case "UAT":
        env = Environment.UAT;
        RequestManger.baseUrl = const String.fromEnvironment('api-base-url');
        break;
      case "PROD":
        env = Environment.PROD;
        RequestManger.baseUrl = const String.fromEnvironment('api-base-url');
        break;
      default:
        env = Environment.PROD;
        RequestManger.baseUrl = const String.fromEnvironment('api-base-url');
    }
  }

  static bool get isProduction => env == Environment.PROD;
}
