import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:freej/app/announcement/repository/announcement_repository.dart';
import 'package:freej/app/campus/repositories/building_repository.dart';
import 'package:freej/app/events/repositories/event_repository.dart';
import 'package:freej/app/posts/post_repository.dart';
import 'package:provider/provider.dart';

import '../../../core/services/api/request_manager.dart';
import '../../../core/services/firebase/fcm_services.dart';
import '../../../core/services/local/shared_pref.dart';
import '../../building/repositories/maintenance_issue_repository.dart';
import '../../notification/repositories/notifications_repository.dart';
import '../models/auth_token.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  static final _loginUrl = "${RequestManger.baseUrl}/auth/access/";
  static final _registerUrl = "${RequestManger.baseUrl}/auth/register/";
  static final _conformRegistrationUrl = "${RequestManger.baseUrl}/auth/register-confirmation/";
  static final _userProfileUrl = "${RequestManger.baseUrl}/campuses/residents/me/";
  static final _requestForgotPasswordOtpUrl = "${RequestManger.baseUrl}/auth/request-change-password/";
  static final _checkForgotPasswordOtpUrl = "${RequestManger.baseUrl}/auth/otp-check/";
  static final _changePasswordUrl = "${RequestManger.baseUrl}/auth/change-password/";
  static final refreshTokenUrl = "${RequestManger.baseUrl}/auth/refresh/";

  static Future<AuthToken> login({required String username, required String password}) async {
    Map<String, String> body = {
      'username': username,
      'password': password,
    };
    return AuthToken.fromMap(
      await RequestManger.fetchObject(url: _loginUrl, method: Method.POST, body: body, needsAuth: false),
    );
  }

  static Future<void> getOtp({
    required String name,
    required String email,
    required String password,
    required String mobile,
    required int room,
  }) async {
    Map<String, dynamic> body = {
      "name": name,
      "email": email,
      "mobile_number": mobile,
      "password": password,
      "room_id": room,
    };
    log('hitting otp endpoint', name: 'getOtp/AuthService');
    await RequestManger.fetchObject(url: _registerUrl, method: Method.POST, body: body, needsAuth: false);
  }

  static Future<void> conformRegistration({
    required String name,
    required String email,
    required String mobile,
    required String password,
    required int room,
    required String otp,
  }) async {
    Map<String, dynamic> body = {
      "name": name,
      "email": email,
      "password": password,
      "mobile_number": mobile,
      "room_id": room,
      "otp": otp,
    };
    log('hitting register endpoint', name: 'register/AuthService');
    await RequestManger.fetchObject(url: _conformRegistrationUrl, method: Method.POST, body: body, needsAuth: false);
  }

  static Future<User> getUserProfile() async {
    log('hitting user profile endpoint', name: 'register/AuthService');
    return User.fromMap(await RequestManger.fetchObject(url: _userProfileUrl, method: Method.GET));
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

  static Future<Map<String, dynamic>> getForgotPasswordOtp({
    required String email,
  }) async {
    Map<String, dynamic> body = {
      "username": email,
    };
    log('hitting forgot password otp endpoint', name: 'getForgotPasswordOtp/AuthService');
    return await RequestManger.fetchObject(
        url: _requestForgotPasswordOtpUrl, method: Method.POST, body: body, needsAuth: false);
  }

  static Future<String> conformForgotPasswordOtp({
    required String email,
    required String otp,
  }) async {
    Map<String, dynamic> body = {
      "username": email,
      "otp": otp,
    };
    log('hitting register endpoint', name: 'conformForgotPasswordOtp/AuthService');
    return (await RequestManger.fetchObject(
        url: _checkForgotPasswordOtpUrl, method: Method.POST, body: body, needsAuth: false))['token'];
  }

  static Future<void> changePassword({
    required String email,
    required String password,
    required String token,
  }) async {
    Map<String, dynamic> body = {
      "username": email,
      "new_password": password,
      "token": token,
    };
    log('hitting changePassword endpoint', name: 'changePassword/AuthService');
    await RequestManger.fetchObject(url: _changePasswordUrl, method: Method.POST, body: body, needsAuth: false);
  }

  static Future<void> logout(BuildContext context, {bool notify = true}) async {
    log(context.read<AuthToken>().access?.token ?? 'No token', name: ('AuthService/logout'));
    await SharedPreference.instance.removeToken();
    AnnouncementRepository.instance.clear();
    MaintenanceIssueRepository.instance.clear();
    EventRepository.instance.clear();
    PostRepository.instance.clear();
    NotificationsRepository.instance.clear();
    await FCM.removeFcmTokenFromDatabase().catchError((_) => {});
    context.read<AuthToken>().remove(notify: notify);
    context.read<User>().remove(notify: notify);
  }
}
