import 'package:flutter/material.dart';

import '../../../core/exports/core.dart';
import '../../../core/services/api/request_manager.dart';

class ReportServices {
  static final _reportsUrl = "${RequestManger.baseUrl}/reports/";

  // I didn't just do this in the services layer, did I?
  static Future<void> createReport(int id, String type, BuildContext context) async {
    try {
      ProgressDialog pr = ProgressDialog(context);
      await pr.show();
      String? comment;
      if (await AlertDialogBox.showAssertionDialog(context,
              message: "add_comment_alert".translate, cancelButton: "no".translate) ??
          false) {
        comment = await CustomInput.showCustomInputSheet(context, title: "report");
      }
      Map<String, dynamic> body = {
        "instance_id": id,
        "instance_type": type,
        "comment": comment,
      };
      await RequestManger.fetchObject(url: _reportsUrl, method: Method.POST, body: body);
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "report_created_successfully".translate);
    } catch (e) {
      AlertDialogBox.showAlert(context, message: e.toString());
    }
  }
}
