import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:freej/core/views/wrapper.dart';

import '../../app/auth/models/auth_token.dart';
import '../../app/auth/models/user.dart';
import '../../app/auth/services/auth_services.dart';
import '../controllers/enum_controller.dart';
import '../services/env/env_manager.dart';
import '../services/local/shared_pref.dart';

class SplashScreenViewModel {
  SplashScreenViewModel();

  Future<void> preLunchActivities(BuildContext context) async {
    SharedPreference.instance.init(context);
    await SharedPreference.instance.getLocale(context);
    // TODO: initialize general repositories
    // Keep User Signed in
    AuthToken? authToken = await SharedPreference.instance.getToken();
    if (authToken?.refresh?.isActive ?? false) {
      // TODO: Refresh access token
      context.read<AuthToken>().updateFromToken(authToken!);
      authToken = context.read<AuthToken>();
      // TODO: initialize user repositories
      try {
        context.read<User>().updateFromUser(await AuthServices.getUserProfile(), switchTab: false);
      } catch (e) {
        log("Error Getting User info", name: "SplashScreen/load");
        log('ERROR:' + e.toString());
        await AuthServices.logout(context);
      }
    }
  }

  Future<void> lunch(context) async {
    Timer(
      const Duration(milliseconds: 1000),
      () => Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
                  FadeTransition(opacity: animation, child: child),
          // pageBuilder: (_, __, ___) => const Wrapper(),
          pageBuilder: (_, __, ___) => EnvironmentManager.isProduction
              ? const Wrapper()
              : Banner(
                  message: Enums.valueString(EnvironmentManager.env),
                  location: BannerLocation.topEnd,
                  child: const Wrapper(),
                ),
        ),
      ),
    );
  }
}
