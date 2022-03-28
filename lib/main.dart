import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:freej/app/auth/models/auth_token.dart';
import 'app/auth/models/user.dart';
import 'core/exports/core.dart';
import 'core/services/env/env_manager.dart';
import 'core/views/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static Locale currentLocale = window.locale;
  static String get lang => currentLocale.languageCode;
  static String get langAlt => currentLocale.languageCode == 'en' ? 'ar' : 'en';
  static void setLocale(BuildContext context) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(currentLocale);
  }

  const MyApp({Key? key}) : super(key: key);
  static final GlobalKey<NavigatorState> _appKey = GlobalKey();
  static GlobalKey get appKey => _appKey;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    EnvironmentManager.init();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<User>(create: (context) => User(), lazy: false),
        ChangeNotifierProvider<AuthToken>(create: (context) => AuthToken(), lazy: false),
      ],
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: MaterialApp(
            navigatorKey: MyApp._appKey,
            debugShowCheckedModeBanner: false,
            title: 'freej',
            locale: _locale,
            supportedLocales: appSupportedLocales,
            localizationsDelegates: const [
              AppLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            theme: ThemeData(
              textTheme: TextTheme(
                bodyLarge: TextStyles.body1,
                bodyMedium: TextStyles.body2,
                bodySmall: TextStyles.body2,
              ),
              fontFamily: 'VarelaRound',
              brightness: Brightness.light,
              splashColor: kTransparent,
              iconTheme: const IconThemeData(color: kFontsColor),
              scaffoldBackgroundColor: kBackgroundColor,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: kPrimaryColor,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: kBackgroundColor,
                titleTextStyle: TextStyles.t1.withColor(kFontsColor),
                iconTheme: const IconThemeData(color: kFontsColor),
                elevation: 0,
              ),
            ),
            builder: (context, widget) => ResponsiveWrapper.builder(
              widget,
              maxWidth: 1200,
              minWidth: 428,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(428, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              ],
              background: Container(color: kBackgroundColor),
            ),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
