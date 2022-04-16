import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freej/app/annoucement/views/announcements_view.dart';
import 'package:freej/app/home/views/home_view.dart';
import 'package:freej/app/profile/views/profile_view.dart';
import 'package:freej/core/localization/constants.dart';

import '../../../core/constants/fz_icons.dart';
import '../../auth/models/user.dart';

class MainScaffoldController {
  BuildContext context;
  late User user;
  int currentIndex = 0;
  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  late List<Widget> _pages;
  late final PageController pageController;

  MainScaffoldController(this.context);

  void init() {
    _pages = [
      const HomeView(),
      const AnnouncementView(),
      const ProfileView(),
    ];
    currentIndex = 0;
    pageController = PageController(initialPage: 0);
  }

  List<Widget> get pages => _pages;

  List<BottomNavigationBarItem> get bottomNavBarItems => _getNavBarItems;

  List<BottomNavigationBarItem> get _getNavBarItems => [
        BottomNavigationBarItem(icon: const Icon(FzIcons.home), label: translateText('home', context: context)),
        BottomNavigationBarItem(icon: const Icon(Icons.speaker_phone_outlined), label: 'announcements'.translate),
        BottomNavigationBarItem(icon: const Icon(CupertinoIcons.profile_circled), label: 'profile'.translate),
      ];
}
