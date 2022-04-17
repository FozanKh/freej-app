import 'package:flutter/material.dart';
import 'package:freej/app/events/repositories/event_repository.dart';
import 'package:freej/core/exports/core.dart';

import '../../events/models/event.dart';
import '../../events/services/event_services.dart';

class HomeViewController {
  final BuildContext context;
  late ProgressDialog pr;

  HomeViewController(this.context) {
    pr = ProgressDialog(context);
  }

  Future<List<Event>> getAllEvents() async {
    try {
      return EventRepository.instance.getAllEvents();
    } catch (e) {
      AlertDialogBox.showAlert(context, message: e.toString().translate);
    }
    return [];
  }

  Future<void> joinEvent(Event event) async {
    pr.show();

    try {
      await EventServices.joinEvent(event);
      pr.hide();
      AlertDialogBox.showAlert(context, message: "event_joined_successfully".translate);
    } catch (e) {
      pr.hide();
      AlertDialogBox.showAlert(context, message: e.toString().translate);
    }
  }
}
