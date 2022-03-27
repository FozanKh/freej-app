import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:freej/app/scaffold/controllers/main_scaffol_controller.dart';

import '../../../core/exports/core.dart';
import '../../auth/models/user.dart';

enum _Pages { HOME, ORDERS, PROFILE }

class MainScaffold extends StatefulWidget {
  const MainScaffold({Key? key}) : super(key: key);

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late final MainScaffoldController controller;
  late User user;
  @override
  void initState() {
    controller = MainScaffoldController(context);
    controller.init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    user = context.watch<User>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        key: Nav.mainScaffoldNavbarKey,
        backgroundColor: kBackgroundColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: kFontsColor,
        selectedItemColor: kPrimaryColor,
        currentIndex: controller.currentIndex,
        iconSize: 25,
        items: controller.bottomNavBarItems,
        onTap: (index) {
          if (index > controller.pages.length - 1) return;
          setState(() {
            controller.key.currentState!.popUntil((_) => !controller.key.currentState!.canPop());
            controller.key.currentState!.maybePop();
            if ((controller.currentIndex - index).abs() > 1) {
              controller.pageController.jumpToPage(index);
            } else {
              controller.pageController
                  .animateToPage(index, duration: const Duration(milliseconds: 150), curve: Curves.easeIn);
            }
            controller.currentIndex = index;
          });
        },
      ),
      body: CustomNavigator(
        navigatorKey: controller.key,
        pageRoute: PageRoutes.cupertinoPageRoute,
        home: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: controller.pages,
        ),
      ),
    );
  }
}
