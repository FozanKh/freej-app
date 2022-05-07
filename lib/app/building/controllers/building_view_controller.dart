import 'package:flutter/material.dart';
import 'package:freej/app/building/models/maintenance_issue.dart';
import 'package:freej/app/building/services/building_services.dart';
import 'package:freej/core/components/bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../core/exports/core.dart';
import '../../auth/models/user.dart';
import '../repositories/maintenance_issue_repository.dart';

class BuildingViewController {
  final BuildContext context;
  late final ProgressDialog pr;
  List<MaintenanceIssue> maintenanceIssues = [];
  GlobalKey<RefreshIndicatorState> maintenanceIssuesRefreshKey = GlobalKey<RefreshIndicatorState>();

  BuildingViewController(this.context) {
    pr = ProgressDialog(context);
  }

  Future<List<MaintenanceIssue>> getAllMaintenanceIssues({bool refresh = false}) async {
    try {
      maintenanceIssues = await MaintenanceIssueRepository.instance.getAllMaintenanceIssues(refresh: refresh);
    } catch (e) {
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
    return maintenanceIssues;
  }

  Future<void> fixMaintenanceIssue(MaintenanceIssue issue) async {
    if (!(await AlertDialogBox.showAssertionDialog(context, message: "are_you_sure_the_problem_is_solved".translate) ??
        false)) {
      return;
    }
    await pr.show();
    try {
      MaintenanceIssue fixedIssue = await BuildingServices.fixMaintenanceIssue(issue);
      MaintenanceIssueRepository.instance.getAllMaintenanceIssues(refresh: true);
      await pr.hide();
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
  }

  Future<bool> createMaintenanceIssue(MaintenanceIssueType type, String description) async {
    await pr.show();
    try {
      await BuildingServices.createMaintenanceIssue(type, description);
      MaintenanceIssueRepository.instance.getAllMaintenanceIssues(refresh: true);
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: 'maintenance_issue_created_successfully');
      return true;
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
      return false;
    }
  }

  Future<void> openWhatsappGroup() async {
    if (context.read<User>().building.whatsAppLink == null) {
      await AlertDialogBox.showAlert(context, message: "no_whatsapp_group_for_your_building_yet_contact");
      return;
    }
    await pr.show();
    try {
      await Nav.openUrl(context, url: context.read<User>().building.whatsAppLink!);
      await pr.hide();
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
  }

  Future<void> editWhatsappGroup() async {
    try {
      String? newUrl = await CustomInput.showCustomInputSheet(
        context,
        title: 'whatsapp_group_url'.translate,
        hint: 'https://chat.whatsapp.com/xxx-xxx-xxx-xxx',
        initialValue: context.read<User>().building.whatsAppLink,
      );
      if (newUrl == null) return;
      if (validateWhatsappGroupLink(newUrl)) {
        await pr.show();
        await BuildingServices.updateBuildingWhatsapp(newUrl);
        await pr.hide();
        await AlertDialogBox.showAlert(context, message: 'whatsapp_group_link_updated_successfully'.translate);
      } else {
        throw (translateText('invalid_error', arguments: ['whatsapp_group_url']));
      }
    } on String catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: 'could_not_update_whatsapp_link'.translate);
    }
  }
}
