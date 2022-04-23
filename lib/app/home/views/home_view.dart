import 'package:flutter/material.dart';
import 'package:freej/app/home/components/home_app_bar.dart';
import 'package:freej/app/home/components/post_card.dart';

import '../../../core/exports/core.dart';
import '../controllers/home_view_controller.dart';
import 'tabs/events_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late final HomeViewController controller;

  @override
  void initState() {
    controller = HomeViewController(context, this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(height: kToolbarHeight * 1.3, user: null),
      floatingActionButton: controller.homeFloatingActionButton,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(boxShadow: Styles.boxShadowBottom, color: kBackgroundColor),
            child: TabBar(
              controller: controller.tabController,
              labelColor: kPrimaryColor,
              isScrollable: false,
              unselectedLabelColor: kDark3,
              indicatorColor: kPrimaryColor,
              tabs: [
                Tab(child: Text('services'.translate, textAlign: TextAlign.center)),
                Tab(child: Text('items'.translate, textAlign: TextAlign.center)),
                Tab(child: Text('events'.translate, textAlign: TextAlign.center)),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.xl),
                  child: SeparatedColumn(
                    separator: const Divider(color: kTransparent),
                    children: List.generate(10, (index) => const PostCard()).toList(),
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.xl),
                  child: SeparatedColumn(
                    separator: const Divider(color: kTransparent),
                    children: List.generate(10, (index) => const PostCard()).toList(),
                  ),
                ),
                EventsTab(controller: controller),
              ],
            ),
          )
        ],
      ),
    );
  }
}
