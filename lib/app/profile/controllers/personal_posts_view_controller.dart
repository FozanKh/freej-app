import 'package:flutter/material.dart';
import 'package:freej/app/events/repositories/event_repository.dart';
import 'package:freej/core/exports/core.dart';
import 'package:provider/provider.dart';
import '../../../core/components/bottom_sheet.dart';
import '../../auth/models/user.dart';
import '../../events/models/event.dart';
import '../../events/services/event_services.dart';
import '../../events/views/edit_event_view.dart';
import '../../posts/models/post.dart';
import '../../posts/post_repository.dart';

class MyPostsViewController {
  final BuildContext context;
  late ProgressDialog pr;
  late final TabController tabController;
  GlobalKey<RefreshIndicatorState> eventsRefreshKey = GlobalKey<RefreshIndicatorState>();
  GlobalKey<RefreshIndicatorState> offersRefreshKey = GlobalKey<RefreshIndicatorState>();
  GlobalKey<RefreshIndicatorState> requestsRefreshKey = GlobalKey<RefreshIndicatorState>();

  MyPostsViewController(this.context, state) {
    pr = ProgressDialog(context);
    tabController = TabController(length: 3, vsync: state);
    tabController.addListener(() {
      state.setState(() {});
    });
  }

  Future<List<Event>> getMyEvents({refresh = false}) async {
    try {
      List<Event> events = await EventRepository.instance.getAllEvents(refresh: refresh);
      List<Event> refinedEvents = events.where(((e) => e.host.id == context.read<User>().id)).toList();
      return refinedEvents;
    } catch (e) {
      AlertDialogBox.showAlert(context, message: e.toString().translate);
    }
    return [];
  }

  Future<List<Post>> getMyOffers({refresh = false}) async {
    try {
      List<Post> posts = await PostRepository.instance.getOffers(refresh: refresh);
      List<Post> refinedPosts = posts.where(((e) => e.owner.id == context.read<User>().id)).toList();
      return refinedPosts;
    } catch (e) {
      AlertDialogBox.showAlert(context, message: e.toString().translate);
    }
    return [];
  }

  Future<List<Post>> getAllRequests({refresh = false}) async {
    try {
      List<Post> posts = await PostRepository.instance.getRequests(refresh: refresh);
      List<Post> refinedPosts = posts.where(((e) => e.owner.id == context.read<User>().id)).toList();
      return refinedPosts;
    } catch (e) {
      AlertDialogBox.showAlert(context, message: e.toString().translate);
    }
    return [];
  }

  Future<void> startEditingEvent(Event event) async {
    await showCustomBottomSheet(context,
        child: EditEventView(callback: editEvent, deleteCallback: deleteEvent, event: event),
        title: 'edit_event'.translate);
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

  Future<bool> deleteEvent(int id) async {
    if (!(await AlertDialogBox.showAssertionDialog(context,
            message: translateText("assurance_alert", arguments: ['delete_event'])) ??
        false)) {
      return false;
    }
    pr.show();
    try {
      await EventServices.deleteEvent(id);
      eventsRefreshKey.currentState?.show();
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "event_deleted_successfully".translate);
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
