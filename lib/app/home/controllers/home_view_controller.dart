import 'package:flutter/material.dart';
import 'package:freej/app/events/repositories/event_repository.dart';
import 'package:freej/core/exports/core.dart';

import '../../../core/constants/phosphor_icons.dart';
import '../../events/models/event.dart';
import '../../events/services/event_services.dart';

class HomeViewController {
  final BuildContext context;
  late ProgressDialog pr;
  late final TabController tabController;

  HomeViewController(this.context, state) {
    pr = ProgressDialog(context);
    tabController = TabController(length: 3, vsync: state);
    tabController.addListener(() {
      state.setState(() {});
    });
  }
  FloatingActionButton get homeFloatingActionButton => FloatingActionButton(
        backgroundColor: tabController.index == 2 ? kGreen : kPrimaryColor,
        child: const Icon(PhosphorIcons.plus_bold, size: 30),
        onPressed: () {},
      );

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
      if (!(await AlertDialogBox.showAssertionDialog(context, message: "join_event_assertion".translate) ?? false)) {
        return;
      }
      await EventServices.joinEvent(event);
      await EventRepository.instance.getAllEvents(refresh: true);
      pr.hide();
      AlertDialogBox.showAlert(context, message: "event_joined_successfully".translate);
    } catch (e) {
      pr.hide();
      AlertDialogBox.showAlert(context, message: e.toString().translate);
    }
  }

  Future<void> leaveEvent(Event event) async {
    pr.show();

    try {
      if (!(await AlertDialogBox.showAssertionDialog(context, message: "leave_event_assertion".translate) ?? false)) {
        return;
      }
      await EventServices.leaveEvent(event);
      await EventRepository.instance.getAllEvents(refresh: true);
      pr.hide();
      AlertDialogBox.showAlert(context, message: "event_left_successfully".translate);
    } catch (e) {
      pr.hide();
      AlertDialogBox.showAlert(context, message: e.toString().translate);
    }
  }

  dispose() {
    tabController.dispose();
  }
}
