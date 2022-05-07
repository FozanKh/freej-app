import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freej/app/home/components/home_app_bar.dart';
import 'package:freej/app/home/views/tabs/offers_tab.dart';
import 'package:freej/app/home/views/tabs/requests_tab.dart';
import 'package:freej/core/constants/phosphor_icons.dart';
import 'package:provider/provider.dart';

import '../../../core/exports/core.dart';
import '../../auth/models/user.dart';
import '../controllers/home_view_controller.dart';
import 'tabs/events_tab.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late User user;
  late final HomeViewController controller;

  @override
  void initState() {
    controller = HomeViewController(context, this);
    super.initState();
  }

  @override
  didChangeDependencies() {
    user = context.read<User>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(height: kToolbarHeight * 1.3, user: user),
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
                Tab(child: Text('requests'.translate, textAlign: TextAlign.center, style: TextStyles.body1)),
                Tab(child: Text('offers'.translate, textAlign: TextAlign.center, style: TextStyles.body1)),
                Tab(child: Text('events'.translate, textAlign: TextAlign.center, style: TextStyles.body1)),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
            child: IntrinsicHeight(
              child: InkWell(
                onTap: () {
                  setState(() => controller.myBuildingOnly = !controller.myBuildingOnly);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Icon(PhosphorIcons.buildings),
                    ),
                    Text(
                      'my_building_only'.translate,
                    ),
                    const Spacer(),
                    Switch(
                      value: controller.myBuildingOnly,
                      onChanged: (value) {
                        setState(() => controller.myBuildingOnly = !controller.myBuildingOnly);
                      },
                      activeColor: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                RequestsTab(controller: controller),
                OffersTab(controller: controller),
                EventsTab(controller: controller),
              ],
            ),
          )
        ],
      ),
    );
  }
}
