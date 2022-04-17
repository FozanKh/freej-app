import 'package:flutter/material.dart';
import 'package:freej/app/events/repositories/event_repository.dart';
import 'package:freej/core/exports/core.dart';

import '../../events/models/event.dart';

class HomeViewController {
  final BuildContext context;

  HomeViewController(this.context);

  Future<List<Event>> getAllEvents() async {
    try {
      return EventRepository.instance.getAllEvents();
    } catch (e) {
      AlertDialogBox.showAlert(context, message: e.toString().translate);
    }
    return [];
  }
}
