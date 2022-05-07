import 'package:flutter/material.dart';

import '../../../core/exports/core.dart';
import '../components/announcement_card.dart';
import '../controllers/announcement_view_controller.dart';

class BuildingAnnouncementsTab extends StatefulWidget {
  final AnnouncementViewController controller;

  const BuildingAnnouncementsTab({Key? key, required this.controller}) : super(key: key);

  @override
  State<BuildingAnnouncementsTab> createState() => _BuildingAnnouncementsTabState();
}

class _BuildingAnnouncementsTabState extends State<BuildingAnnouncementsTab> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: widget.controller.buildingAnnouncementsRefreshKey,
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
              widget.controller.buildingAnnouncements.length,
              (index) => AnnouncementCard(
                announcement: widget.controller.buildingAnnouncements[index],
                deleteAnnouncementCallback: widget.controller.deleteAnnouncement,
              ),
            ).toList(),
          ),
        ),
      ),
    );
  }
}
