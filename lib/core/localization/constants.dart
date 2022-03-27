import 'package:flutter/material.dart';
import 'package:freej/main.dart';
import 'app_localization.dart';

final supportedLanguages = ['en', 'ar'];
const Iterable<Locale> appSupportedLocales = [Locale("en", "US"), Locale("ar", "SA")];
const languagesPath = 'assets/languages';

String translateText(String key, {List<String>? arguments, BuildContext? context}) {
  context ??= MyApp.appKey.currentContext!;
  if (arguments?.isNotEmpty ?? false) {
    String baseText = AppLocalization.of(context)!.translate(key) ?? key;
    for (var i = 0; i < arguments!.length; i++) {
      baseText = baseText.replaceFirst(
          "^[]", AppLocalization.of(context)!.translate(arguments[i])?.toLowerCase() ?? arguments[i]);
    }
    return baseText;
  } else {
    return AppLocalization.of(context)!.translate(key) ?? key;
  }
}

extension StringTranslator on String {
  String get translate => translateText(this);
}

Alignment customAlignment(context, {bool flip = false, top = false, bottom = false}) {
  if (top) {
    if (flip) {
      return isArabic() ? Alignment.topLeft : Alignment.topRight;
    } else {
      return isArabic() ? Alignment.topRight : Alignment.topLeft;
    }
  } else if (bottom) {
    if (flip) {
      return isArabic() ? Alignment.bottomLeft : Alignment.bottomRight;
    } else {
      return isArabic() ? Alignment.bottomRight : Alignment.bottomLeft;
    }
  } else if (flip) {
    return isArabic() ? Alignment.centerLeft : Alignment.centerRight;
  } else {
    return isArabic() ? Alignment.centerRight : Alignment.centerLeft;
  }
}

bool isArabic() {
  return AppLocalization.of(MyApp.appKey.currentContext!)?.locale.languageCode == 'ar' ? true : false;
}
