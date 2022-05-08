import 'package:flutter/material.dart';

import '../../../core/exports/core.dart';
import '../models/notifications.dart';
import '../repositories/notifications_repository.dart';

class NotificationsViewController {
  final BuildContext context;
  late final ProgressDialog pr;

  NotificationsViewController(this.context) {
    pr = ProgressDialog(context);
  }

  Future<List<Notifications>> getAllNotifications({refresh = false}) async {
    try {
      return await NotificationsRepository.instance.getAllNotifications(refresh: refresh);
    } catch (e) {
      AlertDialogBox.showAlert(context, message: e.toString().translate);
    }
    return [];
  }
}
