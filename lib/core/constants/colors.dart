import 'package:flutter/material.dart' show Alignment, Color, Colors, LinearGradient, RadialGradient;

// [Main] Colors
const kPrimaryColor = Color(0xFFf2994a);
const kPrimaryColorDark = Color(0xFFFF6E40);
// const kPrimaryColorLight = Color(0xFFFFAB40);
const kPrimaryColorLight = Color(0xFFFCE5D2);
const kSecondaryColor = Color(0xFF0067FF);
const kSecondaryColorDark = Color(0xFF4094FF);
const kSecondaryColorLight = Color(0xFF40D1FF);
const kTransparent = Colors.transparent;
const kWhite = Colors.white;
const kBlack = Colors.black;
const kGreen = Color(0xFF6BCB77);
const kBlue = Color(0xFF4A7CF2);
const kFontsColor = Color(0xFF707071);
// const kFontsColor = Color(0xFF313131);
const kGrey = Color(0xFF8898A4);
const kInActiveColor = Colors.grey; //Color(0xFF555555);
const kHintFontsColor = Color(0xFF7D7D7D);
// const kHintFontsColor = Colors.grey; //Color(0xFF555555);
const kBackgroundColor = Colors.white; //Color(0xFFEEF4F2);
const kButtonColor = kSecondaryColor;
const kRed2 = Color(0xFFFF5C5C);

// Gradients
const RadialGradient kPrimaryRadialGradient = RadialGradient(
  colors: [
    kPrimaryColorLight,
    kPrimaryColor,
    kPrimaryColorDark,
  ],
);

const LinearGradient kPrimaryLinerGradient = LinearGradient(
  colors: [
    kPrimaryColorDark,
    kPrimaryColor,
    kPrimaryColorLight,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const LinearGradient kPrimaryLinerGradientReversed = LinearGradient(
  colors: [
    kPrimaryColorDark,
    kPrimaryColor,
    kPrimaryColorLight,
  ],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);

const RadialGradient kSecondaryRadialGradient = RadialGradient(
  colors: [
    kSecondaryColorLight,
    kSecondaryColor,
    kSecondaryColorDark,
  ],
);
const LinearGradient kSecondaryLinerGradient = LinearGradient(
  colors: [
    kSecondaryColorLight,
    kSecondaryColor,
    kSecondaryColorDark,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const LinearGradient kSecondaryLinerGradientReversed = LinearGradient(
  colors: [
    kSecondaryColorLight,
    kSecondaryColor,
    kSecondaryColorDark,
  ],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);

// [Core Design System] Colors
const Color kLight0 = Color(0xFFE4E4EB);
const Color kLight1 = Color(0xFFEBEBF0);
const Color kLight2 = Color(0xFFF2F2F2);
const Color kLight3 = Color(0xFFFAFAFC);
const Color kLight4 = Color(0xFFFFFFFF);
const Color kDark1 = Color(0xFF28293D);
const Color kDark2 = Color(0xFF555770);
const Color kDark3 = Color(0xFF8F90A6);
const Color kDark4 = Color(0xFFC7C9D9);
