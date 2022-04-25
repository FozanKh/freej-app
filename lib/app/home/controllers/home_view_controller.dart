import 'package:flutter/material.dart';
import 'package:freej/app/events/repositories/event_repository.dart';
import 'package:freej/core/exports/core.dart';

import '../../../core/components/bottom_sheet.dart';
import '../../../core/constants/phosphor_icons.dart';
import '../../events/models/event.dart';
import '../../events/services/event_services.dart';
import '../../events/views/create_event_view.dart';
import '../../events/views/edit_event_view.dart';

class HomeViewController {
  final BuildContext context;
  late ProgressDialog pr;
  late final TabController tabController;
  GlobalKey<RefreshIndicatorState> eventsRefreshKey = GlobalKey<RefreshIndicatorState>();

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
        onPressed: fabAction,
      );

  VoidCallback get fabAction {
    switch (tabController.index) {
      case 0:
        return () {
          print('0');
        };
      case 1:
        return () {
          print('1');
        };
      case 2:
        return () async {
          await showCustomBottomSheet(context,
              child: CreateEventView(callback: createEvent), title: 'create_event'.translate);
        };
      default:
        return () {
          print('none');
        };
    }
  }

  Future<List<Event>> getAllEvents({refresh = false}) async {
    try {
      return EventRepository.instance.getAllEvents(refresh: refresh);
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
      eventsRefreshKey.currentState?.show();
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
      eventsRefreshKey.currentState?.show();
      pr.hide();
      AlertDialogBox.showAlert(context, message: "event_left_successfully".translate);
    } catch (e) {
      pr.hide();
      AlertDialogBox.showAlert(context, message: e.toString().translate);
    }
  }

  Future<bool> createEvent(String name, EventType type, String description, DateTime date, {int? id}) async {
    pr.show();
    try {
      await EventServices.createEvent(name, type, description, date);
      eventsRefreshKey.currentState?.show();
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "event_created_successfully".translate);
      return true;
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString().translate);
      return false;
    }
  }

  Future<void> startEditingEvent(Event event) async {
    await showCustomBottomSheet(context,
        child: EditEventView(callback: editEvent, event: event), title: 'edit_event'.translate);
  }

  Future<bool> editEvent(String name, EventType type, String description, DateTime date, {int? id}) async {
    pr.show();
    try {
      if (id == null) return false;
      await pr.hide();
      await EventServices.editEvent(id, name, type, description, date);
      eventsRefreshKey.currentState?.show();
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "event_created_successfully".translate);
      return true;
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString().translate);
      return false;
    }
  }

  dispose() {
    tabController.dispose();
  }
}
