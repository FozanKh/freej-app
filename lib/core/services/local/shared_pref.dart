import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import '../../../app/auth/models/auth_token.dart';
import '../../../app/auth/models/token.dart';
import '../../../main.dart';

class SharedPreference {
  late BuildContext? _context;
  SharedPreference._();
  static SharedPreference? _instance;
  static SharedPreference get instance => _instance ??= SharedPreference._();

  void init(context) {
    instance._context = context;
  }

  Future<bool> save(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) return await prefs.setInt(key, value);
    if (value is bool) return await prefs.setBool(key, value);
    if (value is double) return await prefs.setDouble(key, value);
    return await prefs.setString(key, value);
  }

  Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    print(await prefs.remove(key));
  }

  // *  OnBoarding pages Control
  isFirstLaunch() async {
    return await read('firstLaunch') ?? true;
  }

  setFirstLaunch() async {
    return save('firstLaunch', false);
  }

  removeFirstLaunch() async {
    return save('firstLaunch', true);
  }

  // * Localization Control
  getLocale(context) async {
    String? locale = await read('locale');
    if (locale != null && ui.window.locale.languageCode != locale) switchLocale(context);
  }

  setLocale(String locale) async {
    save('locale', locale);
  }

  switchLocale(context) async {
    MyApp.currentLocale = MyApp.currentLocale.languageCode == 'ar' ? const Locale('en') : const Locale('ar');
    setLocale(MyApp.currentLocale.languageCode);
    MyApp.setLocale(context);
  }

  switchLocaleToArabic(context) async {
    MyApp.currentLocale = const Locale('ar');
    setLocale(MyApp.currentLocale.languageCode);
    MyApp.setLocale(context);
  }

  switchLocaleToEnglish(context) async {
    MyApp.currentLocale = const Locale('en');
    setLocale(MyApp.currentLocale.languageCode);
    MyApp.setLocale(context);
  }

  // * AuthToken Control
  Future<AuthToken?> getToken() async {
    String? refresh = await read('refresh-token');
    String? access = await read('access-token');
    if (refresh != null && access != null) {
      return AuthToken.fromTokens(
        access: Token(token: access),
        refresh: Token(token: refresh),
      );
    }
    return null;
  }

  Future<void> saveToken(AuthToken authToken, {notify = true}) async {
    await save('refresh-token', authToken.refresh?.token);
    await save('access-token', authToken.access?.token);
    _context?.read<AuthToken>().updateFromToken(authToken, notify: notify);
  }

  Future<void> removeToken() async {
    await remove('refresh-token');
    await remove('access-token');
  }

  Future<void> setLastNotificationCheck() async {
    await save('last-notification-check', DateTime.now().toIso8601String());
  }

  Future<DateTime?> getLastNotificationCheck() async {
    String date = await read('last-notification-check');
    return DateTime.tryParse(date);
  }
}
