import 'package:flutter/material.dart';
import 'package:freej/app/annoucement/componenets/announcement_card.dart';

import '../../../core/exports/core.dart';
import '../../home/components/home_app_bar.dart';
import '../../home/components/post_card.dart';
import '../controllers/announcement_view_controller.dart';
import '../models/announcement.dart';

class AnnouncementView extends StatefulWidget {
  const AnnouncementView({Key? key}) : super(key: key);

  @override
  State<AnnouncementView> createState() => _AnnouncementViewState();
}

class _AnnouncementViewState extends State<AnnouncementView> with SingleTickerProviderStateMixin {
  late final AnnouncementViewController controller;
  late final TabController tabController;

  @override
  void initState() {
    controller = AnnouncementViewController(context);
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
                Tab(child: Text('building'.translate, textAlign: TextAlign.center)),
                Tab(child: Text('campus'.translate, textAlign: TextAlign.center)),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Announcement>>(
                future: controller.getAnnouncement(),
                builder: (context, announcements) {
                  if (!announcements.hasData) return const Center(child: CircularProgressIndicator());
                  return TabBarView(
                    controller: tabController,
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.xl),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
                            minWidth: MediaQuery.of(context).size.width,
                          ),
                          child: Column(
                            children: List.generate(
                              controller.buildingAnnouncements.length,
                              (index) => AnnouncementCard(
                                announcement: controller.buildingAnnouncements[index],
                              ),
                            ).toList(),
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
                          child: Column(
                            children: List.generate(
                              controller.campusAnnouncements.length,
                              (index) => AnnouncementCard(
                                announcement: controller.campusAnnouncements[index],
                              ),
                            ).toList(),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
