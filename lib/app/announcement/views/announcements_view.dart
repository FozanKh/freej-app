import 'package:flutter/material.dart';
import 'package:freej/app/announcement/components/announcement_card.dart';
import 'package:freej/app/announcement/views/campus_announcements_tab.dart';
import 'package:provider/provider.dart';

import '../../../core/exports/core.dart';
import '../../auth/models/user.dart';
import '../../home/components/home_app_bar.dart';
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
  late User user;

  @override
  void initState() {
    controller = AnnouncementViewController(context);
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  didChangeDependencies() {
    user = context.read<User>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(height: kToolbarHeight * 1.3, user: user),
      floatingActionButton: controller.fab,
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
                future: controller.getAnnouncements(),
                builder: (context, announcements) {
                  if (!announcements.hasData || announcements.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (!announcements.hasData || (announcements.data?.isEmpty ?? true)) {
                    return Center(child: FullScreenBanner("no_announcements_available".translate));
                  }
                  return TabBarView(
                    controller: tabController,
                    children: [
                      if (controller.buildingAnnouncements.isEmpty)
                        Center(child: FullScreenBanner("no_announcements_available".translate))
                      else
                        RefreshIndicator(
                          key: controller.buildingAnnouncementsRefreshKey,
                          onRefresh: () => controller.getAnnouncements(refresh: true).then((value) => setState(() {})),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.xl),
                            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                                    deleteAnnouncementCallback: controller.deleteAnnouncement,
                                  ),
                                ).toList(),
                              ),
                            ),
                          ),
                        ),
                      if (controller.campusAnnouncements.isEmpty)
                        Center(child: FullScreenBanner("no_announcements_available".translate))
                      else
                        CampusAnnouncementsTab(controller: controller),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
