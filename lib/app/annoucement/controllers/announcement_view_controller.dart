import 'package:flutter/material.dart';
import 'package:freej/app/annoucement/models/announcement.dart';
import 'package:freej/app/annoucement/models/commercial_announcement.dart';
import 'package:freej/app/annoucement/repository/announcement_repository.dart';

import '../../../core/exports/core.dart';

class AnnouncementViewController {
  final BuildContext context;
  late ProgressDialog pr;
  List<Announcement> buildingAnnouncements = [];
  List<Announcement> campusAnnouncements = [];

  AnnouncementViewController(this.context) {
    pr = ProgressDialog(context);
  }

  Future<List<Announcement>> getAnnouncement() async {
    List<Announcement> announcement = await AnnouncementRepository.instance.getAllAnnouncements();
    campusAnnouncements = announcement.where((element) => element.type == AnnouncementType.campus).toList();
    buildingAnnouncements = announcement.where((element) => element.type == AnnouncementType.building).toList();
    return announcement;
  }

  Future<List<CommercialAnnouncement>> getCommercialAnnouncement() async {
    return await AnnouncementRepository.instance.getAllCommercialAnnouncements();
  }
}
