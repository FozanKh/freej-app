import 'package:flutter/material.dart';

import '../exports/core.dart';

class Insets {
  static const double scale = 1;

  static const double xs = 2 * scale;

  static const double s = 6 * scale;

  static const double m = 12 * scale;

  static const double l = 20 * scale;

  static const double xl = 24 * scale;

  static const double xxl = 36 * scale;
}

class Sizes {
  static const double xxlCardHeight = 160.0;

  static const double xlCardHeight = 120.0;

  static const double lCardHeight = 80.0;

  static const double mCardHeight = 50.0;

  static const double sCardHeight = 40.0;

  static const double scale = 1;

  static const double mIcon = 20;

  static const double lIcon = 30;

  static const double xlIcon = 40;

  static const double sideBarSm = 150 * scale;

  static const double sideBarMed = 200 * scale;

  static const double sideBarLg = 290 * scale;

  static const double topBarHeight = 60;

  static const double topBarPadding = Insets.l;

  static const double topBar = topBarPadding + topBarHeight;
}

class Fonts {
  static const String fredokaOne = "FredokaOne";
  static const String varelaRound = "VarelaRound";
}

class TextStyles {
  static const TextStyle fredokaOne = TextStyle(
    fontFamily: Fonts.fredokaOne,
    fontWeight: FontWeight.w400,
    // TODO: make sure removing the color here doesn't have any effect on random views
    // color: kFontsColor,
    height: 1.1,
    fontFamilyFallback: [
      'Tajawal',
    ],
  );

  static const TextStyle varelaRound = TextStyle(
    fontFamily: Fonts.varelaRound,
    fontWeight: FontWeight.w400,
    // TODO: make sure removing the color here doesn't have any effect on random views
    // color: kFontsColor,
    fontFamilyFallback: [
      'Tajawal',
    ],
    height: 1.1,
  );

  /// fontWeight: FontWeight.bold, letterSpacing: 0.7, fontSize: 32
  static TextStyle get logo => fredokaOne.copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.7, fontSize: 32);

  /// fontWeight: FontWeight.bold, letterSpacing: 0.7, fontSize: 26
  static TextStyle get t1 => varelaRound.copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.7, fontSize: 26);

  /// fontWeight: FontWeight.bold, letterSpacing: 0.4, fontSize: 22
  static TextStyle get t2 => varelaRound.copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.4, fontSize: 22);

  /// fontSize: 20
  static TextStyle get h1 => varelaRound.copyWith(fontSize: 20);

  /// fontSize: 18
  static TextStyle get h2 => varelaRound.copyWith(fontSize: 18);

  /// fontSize: 16
  static TextStyle get body1 => varelaRound.copyWith(fontSize: 16);

  /// fontSize: 14
  static TextStyle get body2 => varelaRound.copyWith(fontSize: 14);

  /// fontSize: 13
  static TextStyle get body3 => varelaRound.copyWith(fontSize: 13);

  /// fontSize: 16, letterSpacing: 1.75
  static TextStyle get callOut => varelaRound.copyWith(fontSize: 16, letterSpacing: 1.75);

  /// fontWeight: FontWeight.bold
  static TextStyle get callOutFocus => callOut.copyWith(fontWeight: FontWeight.bold);

  /// letterSpacing: 1.75
  static TextStyle get button => callOut.copyWith(letterSpacing: 1.75);

  /// fontWeight: FontWeight.normal
  static TextStyle get buttonSelected => button.copyWith(fontWeight: FontWeight.normal);

  static TextStyle get footnote => body3;

  static TextStyle get hint => body3.withColor(kGrey);

  static TextStyle get hint2 => hint.withSize(11);

  /// letterSpacing: 0.3
  static TextStyle get caption => footnote.copyWith(letterSpacing: 0.3);
}

class Borders {
  static final Border blackBorder = Border.all(color: kFontsColor, width: 1.5);

  static const BorderRadius sBorderRadius = BorderRadius.all(Radius.circular(5));
  static const BorderRadius mBorderRadius = BorderRadius.all(Radius.circular(10));
  static const BorderRadius lBorderRadius = BorderRadius.all(Radius.circular(15));
  static const BorderRadius xlBorderRadius = BorderRadius.all(Radius.circular(25));
  static BorderRadius diagonalBorderRadius(BuildContext context, double radius) => BorderRadius.only(
        topLeft: !isArabic() ? Radius.circular(radius) : Radius.zero,
        bottomRight: !isArabic() ? Radius.circular(radius) : Radius.zero,
        topRight: isArabic() ? Radius.circular(radius) : Radius.zero,
        bottomLeft: isArabic() ? Radius.circular(radius) : Radius.zero,
      );
}

class Styles {
  static const List<BoxShadow> boxShadow = [
    BoxShadow(blurRadius: 7, color: Colors.black12, offset: Offset(0, 4)),
  ];
  static const List<BoxShadow> boxShadowTop = [
    BoxShadow(blurRadius: 4, color: Colors.black12, offset: Offset(0, -1)),
  ];
  static const List<BoxShadow> boxShadowBottom = [
    BoxShadow(blurRadius: 3, spreadRadius: 0, color: Colors.black12, offset: Offset(0, 3)),
  ];
  static const List<BoxShadow> boxShadowHeavy = [
    BoxShadow(blurRadius: 10, color: Colors.black38, offset: Offset(-2, 2)),
  ];
  static const BoxDecoration kContainerDecoration =
      BoxDecoration(boxShadow: boxShadow, borderRadius: Borders.mBorderRadius, color: kWhite);
}
