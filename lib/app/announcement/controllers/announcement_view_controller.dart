import 'package:flutter/material.dart';
import 'package:freej/app/announcement/models/announcement.dart';
import 'package:freej/app/announcement/models/commercial_announcement.dart';
import 'package:freej/app/announcement/repository/announcement_repository.dart';
import 'package:freej/app/announcement/services/announcement_services.dart';
import 'package:freej/app/announcement/views/create_announcement_view.dart';
import 'package:provider/provider.dart';

import '../../../core/components/bottom_sheet.dart';
import '../../../core/constants/phosphor_icons.dart';
import '../../../core/exports/core.dart';
import '../../auth/models/user.dart';

class AnnouncementViewController {
  final BuildContext context;
  late ProgressDialog pr;
  List<Announcement> buildingAnnouncements = [];
  List<Announcement> campusAnnouncements = [];
  GlobalKey<RefreshIndicatorState> buildingAnnouncementsRefreshKey = GlobalKey<RefreshIndicatorState>();
  GlobalKey<RefreshIndicatorState> campusAnnouncementsRefreshKey = GlobalKey<RefreshIndicatorState>();

  AnnouncementViewController(this.context) {
    pr = ProgressDialog(context);
  }

  FloatingActionButton? get fab {
    if (context.read<User>().isSupervisor ?? false) {
      return FloatingActionButton(
        child: const Icon(PhosphorIcons.plus_bold),
        onPressed: () => showCustomBottomSheet(context,
            child: CreateAnnouncementView(callback: sendAnnouncement), title: 'send_building_announcement'.translate),
      );
    } else {
      return null;
    }
  }

  Future<List<Announcement>> getAnnouncements({bool refresh = false}) async {
    List<Announcement> announcement = await AnnouncementRepository.instance.getAllAnnouncements(refresh: refresh);
    campusAnnouncements = announcement.where((element) => element.type == AnnouncementType.campus).toList();
    buildingAnnouncements = announcement.where((element) => element.type == AnnouncementType.building).toList();
    return announcement;
  }

  Future<List<CommercialAnnouncement>> getCommercialAnnouncement() async {
    return await AnnouncementRepository.instance.getAllCommercialAnnouncements();
  }

  Future<bool> sendAnnouncement(String title, String description) async {
    await pr.show();
    try {
      await AnnouncementServices.sendAnnouncement(title, description);
      buildingAnnouncementsRefreshKey.currentState?.show();
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: 'announcement_created_successfully'.translate);
      return true;
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
      return false;
    }
  }

  Future<void> deleteAnnouncement(Announcement announcement) async {
    if (!(context.read<User>().isSupervisor ?? false)) {
      await AlertDialogBox.showAlert(context, message: 'you_dont_have_permission'.translate);
      return;
    }

    if (!(await AlertDialogBox.showAssertionDialog(context,
            message: translateText("assurance_alert", arguments: ['delete_announcement'])) ??
        false)) {
      return;
    }
    await pr.show();
    try {
      await AnnouncementServices.deleteAnnouncement(announcement);
      buildingAnnouncementsRefreshKey.currentState?.show();
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: 'announcement_deleted_successfully'.translate);
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
  }
}
