import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../main.dart';

extension LocalizedInsets on EdgeInsets {
  EdgeInsets relative() {
    if (Directionality.of(MyApp.appKey.currentContext!) == TextDirection.rtl) {
      return EdgeInsets.fromLTRB(right, top, left, bottom);
    } else {
      return EdgeInsets.fromLTRB(left, top, right, bottom);
    }
  }

  operator +(EdgeInsets insets) {
    return EdgeInsets.only(
        top: top + insets.top, left: left + insets.left, bottom: bottom + insets.bottom, right: right + insets.right);
  }
}

extension LocalizedBorder on Border {
  Border relative() {
    if (Directionality.of(MyApp.appKey.currentContext!) == TextDirection.rtl) {
      return Border(bottom: bottom, left: right, right: left, top: top);
    } else {
      return this;
    }
  }
}

extension LocalizedAlignment on Alignment {
  Alignment relative() {
    if (Directionality.of(MyApp.appKey.currentContext!) == TextDirection.rtl) {
      return Alignment(x * -1, y);
    } else {
      return Alignment(x, y);
    }
  }
}

extension HexColor on Color {
  static Color? fromHex(String hexString) {
    hexString = hexString.replaceAll("#", "");
    if (hexString.length == 6) {
      hexString = "FF" + hexString;
    }
    if (hexString.length == 8) {
      return Color(int.parse("0x$hexString"));
    } else {
      return null;
    }
  }

  String get hex => '#${value.toRadixString(16).substring(2)}';
}

extension TextStyleExtensions on TextStyle {
  /// Shortcut for color
  TextStyle withColor(Color v) => copyWith(color: v);

  /// Shortcut for fontSize
  TextStyle withSize(double v) => copyWith(fontSize: v);

  /// Shortcut for fontWeight
  TextStyle withWeight(FontWeight v) => copyWith(fontWeight: v);
}

extension ArNumbersConverter on String {
  get validateNumbers {
    Map<String, String> arNumbersConverter = {
      "٠": "0",
      "١": "1",
      "٢": "2",
      "٣": "3",
      "٤": "4",
      "٥": "5",
      "٦": "6",
      "٧": "7",
      "٨": "8",
      "٩": "9",
    };
    return characters.map((e) => arNumbersConverter[e] ?? e).join();
  }
}

extension PrettyJson on Map {
  String get prettyJson {
    return const JsonEncoder.withIndent('  ').convert(this);
  }
}

extension DateTimeExtension on DateTime {
  /// e.g. 12:00 AM
  String get dayTime12 {
    return DateFormat('hh:mm a', MyApp.lang).format(this);
  }

  /// e.g. Aug 10, 1999 12:00 AM
  String get yMMMMdhm {
    return DateFormat.yMMMd(MyApp.lang).add_jm().format(this);
  }

  /// e.g.  August 10, 1999
  String get yMMMMd {
    return DateFormat.yMMMMd(MyApp.lang).format(this);
  }

  /// e.g. 10-08-1999
  String get dateString {
    return DateFormat('dd-MM-y', MyApp.lang).format(this);
  }

  /// e.g. 10-08-1999 03:49:28 AM
  String get dateTimeString {
    return DateFormat('dd-MM-y hh:mm:ss a', MyApp.lang).format(this);
  }

  /// e.g. 22:26
  String get Hm {
    return DateFormat.Hm(MyApp.lang).format(this);
  }

  /// e.g. 10/8/1999
  String get yMd {
    return DateFormat.yMd(MyApp.lang).format(this);
  }

  /// 10 August
  String get dMMMM {
    return DateFormat('dd MMMM', MyApp.lang).format(this);
  }

  /// 10 Aug
  String get dMMM {
    return DateFormat('dd MMM', MyApp.lang).format(this);
  }

  /// e.g. Sun
  String get e {
    return DateFormat('E', MyApp.lang).format(this);
  }

  /// e.g. Sunday
  String get eeee {
    return DateFormat('EEEE', MyApp.lang).format(this);
  }
}
