import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:freej/app/auth/services/samples.dart';
import 'package:freej/app/campus/services/samples.dart';
import 'package:provider/provider.dart';

import '../../../core/services/api/request_manager.dart';
import '../../../core/services/local/shared_pref.dart';
import '../../campus/models/building.dart';
import '../models/auth_token.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  static final _loginUrl = "${RequestManger.baseUrl}/auth/access/";
  static final _registerUrl = "${RequestManger.baseUrl}/auth/register/";
  static final _conformRegistrationUrl = "${RequestManger.baseUrl}/auth/register-confirmation/";
  static final _buildingsUrl = "${RequestManger.baseUrl}/campuses/<pk>/buildings/";
  static final _userProfileUrl = "${RequestManger.baseUrl}/customers/me/";
  static final refreshTokenUrl = "${RequestManger.baseUrl}/auth/refresh/";

  static Future<AuthToken> login({required String username, required String password}) async {
    Map<String, String> body = {
      'username': username,
      'password': password,
    };
    // return AuthToken.fromMap(
    //   await RequestManger.fetchObject(url: _loginUrl, method: Method.POST, body: body, needsAuth: false),
    // );
    return AuthToken.fromMap(kAuthTokenSample);
  }

  static Future<void> getOtp({
    required String email,
    required String password,
    required int room,
  }) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
      "room_id": room,
    };
    log('hitting otp endpoint', name: 'getOtp/AuthService');
    // await RequestManger.fetchObject(url: _registerUrl, method: Method.POST, body: body, needsAuth: false);
  }

  static Future<void> conformRegistration({
    required String email,
    required String password,
    required int room,
    required String otp,
  }) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
      "room_id": room,
      "otp": otp,
    };
    log('hitting register endpoint', name: 'register/AuthService');
    // await RequestManger.fetchObject(url: _conformRegistrationUrl, method: Method.POST, body: body, needsAuth: false);
  }

  static Future<List<Building>> getBuildings() async {
    log('getting supported corporates', name: 'getSupportedCorporates/AuthService');

    // return (await RequestManger.fetchList(url: _buildingsUrl, method: Method.GET, needsAuth: false))
    //     .map((e) => Building.fromMap(e))
    //     .toList();
    return kBuildingsSample.map((e) => Building.fromMap(e)).toList();
  }

  static Future<User> getUserProfile() async {
    log('hitting user profile endpoint', name: 'register/AuthService');
    // return User.fromMap(await RequestManger.fetchObject(url: _userProfileUrl, method: Method.GET));
    return User.fromMap(kUserSample);
  }

  static Future<bool> refreshAuthTokens(AuthToken authToken) async {
    log('refreshing auth tokens', name: 'AuthServices/refreshAuthTokens');
    if (authToken.refresh == null) return false;

    final data = {
      'refresh': authToken.refresh?.token ?? '',
    };

    http.Response res = await http.post(Uri.parse(refreshTokenUrl), body: data);
    if (await RequestManger.validateResponse(response: res)) {
      Map<String, dynamic> result = jsonDecode(res.body);
      if (result.isNotEmpty) {
        AuthToken token = AuthToken.fromMap(result);
        await SharedPreference.instance.saveToken(token);
        log('refreshed successfully', name: 'AuthServices/refreshAuthTokens');
        return true;
      } else {
        throw ('Error, could not validate your information, please try again');
      }
    } else {
      throw ('Error, could not validate your information, please try again');
    }
  }

  static Future<void> logout(BuildContext context, {bool notify = true}) async {
    log(context.read<AuthToken>().access?.token ?? 'No token', name: ('AuthService/logout'));
    await SharedPreference.instance.removeToken();
    context.read<AuthToken>().remove(notify: notify);
    context.read<User>().remove(notify: notify);
  }
}
