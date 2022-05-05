import 'package:flutter/material.dart';

import '../../../core/exports/core.dart';
import '../controllers/my_applications_view_controller.dart';
import 'applications/my_applied_events_tab.dart';
import 'applications/my_applied_offers_tab.dart';
import 'applications/my_applied_requests_tab.dart';

class MyApplicationsView extends StatefulWidget {
  const MyApplicationsView({Key? key}) : super(key: key);

  @override
  State<MyApplicationsView> createState() => _MyApplicationsViewState();
}

class _MyApplicationsViewState extends State<MyApplicationsView> with SingleTickerProviderStateMixin {
  late final MyApplicationsViewController controller;

  @override
  void initState() {
    controller = MyApplicationsViewController(context, this);
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
        title: Text('my_applications'.translate),
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
                Tab(child: Text('requests'.translate, textAlign: TextAlign.center)),
                Tab(child: Text('offers'.translate, textAlign: TextAlign.center)),
                Tab(child: Text('events'.translate, textAlign: TextAlign.center)),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                MyAppliedRequestsTab(controller: controller),
                MyAppliedOffersTab(controller: controller),
                MyAppliedEventsTab(controller: controller),
              ],
            ),
          )
        ],
      ),
    );
  }
}
