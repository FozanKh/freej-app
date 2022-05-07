import 'package:flutter/material.dart';
import 'package:freej/app/announcement/components/announcement_card.dart';

import '../../../core/exports/core.dart';
import '../controllers/announcement_view_controller.dart';

class CampusAnnouncementsTab extends StatefulWidget {
  final AnnouncementViewController controller;

  const CampusAnnouncementsTab({Key? key, required this.controller}) : super(key: key);

  @override
  State<CampusAnnouncementsTab> createState() => _CampusAnnouncementsTabState();
}

class _CampusAnnouncementsTabState extends State<CampusAnnouncementsTab> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: widget.controller.campusAnnouncementsRefreshKey,
      onRefresh: () => widget.controller.getAnnouncements(refresh: true).then((value) => setState(() {})),
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
              widget.controller.campusAnnouncements.length,
              (index) => AnnouncementCard(
                announcement: widget.controller.campusAnnouncements[index],
                deleteAnnouncementCallback: () {},
              ),
            ).toList(),
          ),
        ),
      ),
    );
  }
}
