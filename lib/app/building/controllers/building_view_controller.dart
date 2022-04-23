import 'package:flutter/material.dart';
import 'package:freej/app/building/models/maintenance_issue.dart';
import 'package:freej/app/building/services/building_services.dart';
import 'package:provider/provider.dart';

import '../../../core/exports/core.dart';
import '../../auth/models/user.dart';
import '../repositories/maintenance_issue_repository.dart';

class BuildingViewController {
  final BuildContext context;
  late final ProgressDialog pr;
  List<MaintenanceIssue> maintenanceIssues = [];

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
    if (!(await AlertDialogBox.showAssertionDialog(context, message: "are_you_sure_the_problem_is_solved") ?? false)) {
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
}
