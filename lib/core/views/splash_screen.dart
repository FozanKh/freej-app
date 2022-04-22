import 'package:flutter/material.dart';
import 'package:freej/core/views/splash_screen_view_model.dart';
import '../exports/core.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = SplashScreenViewModel();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      controller.preLunchActivities(context);
      controller.lunch(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        color: kPrimaryColor,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 4),
        alignment: Alignment.center,
        child: FadeIn(
            child: Image.asset(Assets.kFreejWhiteLogoAsset), delay: 200, duration: const Duration(milliseconds: 200)),
      ),
    );
  }
}
