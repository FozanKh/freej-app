import 'package:flutter/material.dart';
import 'package:freej/app/home/components/home_app_bar.dart';
import 'package:freej/app/home/components/post_card.dart';

import '../../../core/exports/core.dart';
import '../controllers/home_view_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late final HomeViewController controller;
  late final TabController tabController;

  @override
  void initState() {
    controller = HomeViewController(context);
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(height: kToolbarHeight * 1.3, user: null),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(boxShadow: Styles.boxShadowBottom, color: kBackgroundColor),
            child: TabBar(
              controller: tabController,
              labelColor: kPrimaryColor,
              isScrollable: false,
              unselectedLabelColor: kDark3,
              indicatorColor: kPrimaryColor,
              tabs: [
                Tab(child: Text('services'.translate, textAlign: TextAlign.center)),
                Tab(child: Text('items'.translate, textAlign: TextAlign.center)),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.xl),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    child: SeparatedColumn(
                      separator: const Divider(color: kTransparent),
                      children: List.generate(10, (index) => PostCard()).toList(),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.xl),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    child: SeparatedColumn(
                      separator: const Divider(color: kTransparent),
                      children: List.generate(10, (index) => PostCard()).toList(),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
