import 'package:flutter/material.dart';

import '../../../core/exports/core.dart';
import '../controllers/my_posts_view_controller.dart';
import 'posts/my_events_tab.dart';
import 'posts/my_offers_tab.dart';
import 'posts/my_requests_tab.dart';

class MyPostsView extends StatefulWidget {
  const MyPostsView({Key? key}) : super(key: key);

  @override
  State<MyPostsView> createState() => _MyPostsViewState();
}

class _MyPostsViewState extends State<MyPostsView> with SingleTickerProviderStateMixin {
  late final MyPostsViewController controller;

  @override
  void initState() {
    controller = MyPostsViewController(context, this);
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
      appBar: AppBar(
        title: Text('my_posts'.translate),
      ),
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
                Tab(child: Text('requests'.translate, textAlign: TextAlign.center, style: TextStyles.body1)),
                Tab(child: Text('offers'.translate, textAlign: TextAlign.center, style: TextStyles.body1)),
                Tab(child: Text('events'.translate, textAlign: TextAlign.center, style: TextStyles.body1)),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                MyRequestsTab(controller: controller),
                MyOffersTab(controller: controller),
                MyEventsTab(controller: controller),
              ],
            ),
          )
        ],
      ),
    );
  }
}
