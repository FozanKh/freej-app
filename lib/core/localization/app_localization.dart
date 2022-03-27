import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

class AppLocalization {
  AppLocalization(this.locale);

  final Locale locale;
  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  Map<String, dynamic>? _localizedValues;

  Future<void> load() async {
    String jsonStringValues = await rootBundle.loadString('$languagesPath/${locale.languageCode}.json');
    _localizedValues = json.decode(jsonStringValues);
  }

  //reformating the key as needed
  String findKey(String key) {
    if (key.characters.last == '.') {
      key = key.replaceAll('.', '');
    }
    return key;
  }

  dynamic translate(String key) {
    dynamic result;
    try {
      key = findKey(key);
      if (key.contains('.')) {
        List<String> keys = key.split('.');
        result = keys.length == 2 ? _localizedValues![keys[0]][keys[1]] : _localizedValues![keys[0]][keys[1]][keys[2]];
        result ??= keys.length == 2
            ? _localizedValues![findKey(keys[0])][findKey(keys[1])]
            : _localizedValues![findKey(keys[0])][findKey(keys[1])][findKey(keys[2])];

        return result;
      }
      result = _localizedValues![key];
      result ??= _localizedValues![findKey(key)];

      return result;
    } catch (err) {
      log("Error translating $key");
      return key;
    }
  }

  // static member to have simple access to the delegate from Material App
  static const LocalizationsDelegate<AppLocalization> delegate = _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return supportedLanguages.contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
