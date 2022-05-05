import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freej/app/events/repositories/event_repository.dart';
import 'package:freej/core/exports/core.dart';
import 'package:provider/provider.dart';
import '../../../core/components/bottom_sheet.dart';
import '../../../core/services/firebase/storage_services.dart';
import '../../auth/models/user.dart';
import '../../events/models/event.dart';
import '../../events/services/event_services.dart';
import '../../events/views/edit_event_view.dart';
import '../../posts/models/post.dart';
import '../../posts/post_repository.dart';
import '../../posts/services/post_services.dart';
import '../../posts/view/edit_post_view.dart';

class MyApplicationsViewController {
  final BuildContext context;
  late ProgressDialog pr;
  late final TabController tabController;
  GlobalKey<RefreshIndicatorState> eventsRefreshKey = GlobalKey<RefreshIndicatorState>();
  GlobalKey<RefreshIndicatorState> offersRefreshKey = GlobalKey<RefreshIndicatorState>();
  GlobalKey<RefreshIndicatorState> requestsRefreshKey = GlobalKey<RefreshIndicatorState>();

  MyApplicationsViewController(this.context, state) {
    pr = ProgressDialog(context);
    tabController = TabController(length: 3, vsync: state);
    tabController.addListener(() {
      state.setState(() {});
    });
  }

  Future<List<Event>> getMyAppliedEvents({refresh = false}) async {
    try {
      List<Event> events = await EventRepository.instance.getAllEvents(refresh: refresh);
      List<Event> refinedEvents = events.where(((e) => e.applicationStatus != EventApplicationStatus.unknown)).toList();
      return refinedEvents;
    } catch (e) {
      AlertDialogBox.showAlert(context, message: e.toString().translate);
    }
    return [];
  }

  Future<List<Post>> getMyAppliedOffers({refresh = false}) async {
    try {
      List<Post> posts = await PostRepository.instance.getOffers(refresh: refresh);
      List<Post> refinedPosts = posts.where(((e) => e.applicationStatus != PostApplicationStatus.unknown)).toList();
      return refinedPosts;
    } catch (e) {
      AlertDialogBox.showAlert(context, message: e.toString().translate);
    }
    return [];
  }

  Future<List<Post>> getMyAppliedRequests({refresh = false}) async {
    try {
      List<Post> posts = await PostRepository.instance.getRequests(refresh: refresh);
      List<Post> refinedPosts = posts.where(((e) => e.applicationStatus != PostApplicationStatus.unknown)).toList();
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

  Future<void> startEditingPost(Post post) async {
    await showCustomBottomSheet(
      context,
      child: EditPostView(
        callback: editPost,
        deleteCallback: deletePost,
        post: post,
        type: post.type,
      ),
      title: 'edit_post'.translate,
    );
  }

  Future<bool> editPost(Post post, String title, String description, List<File> images) async {
    pr.show();
    try {
      List<String> imagesUrls = [];
      int counter = 1;
      for (var image in images) {
        String? url = await StorageServices.uploadFile(
          file: image,
          ref:
              'users/${context.read<User>().id}/posts/${post.type.name}/images/$title-$counter-${DateTime.now().millisecondsSinceEpoch}.'
                  .toLowerCase(),
        );
        counter++;
        if (url != null) {
          imagesUrls.add(url);
        }
      }
      // TODO: implement edit images func
      await PostServices.editPost(post, title, description, post.images ?? []);

      if (post.type == PostType.offer) {
        offersRefreshKey.currentState?.show();
      } else {
        requestsRefreshKey.currentState?.show();
      }

      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "post_edit_successfully".translate);
      return true;
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString().translate);
      return false;
    }
  }

  // TODO: Translate this
  Future<bool> deletePost(Post post) async {
    if (!(await AlertDialogBox.showAssertionDialog(context,
            message: translateText("assurance_alert", arguments: ['delete_post'])) ??
        false)) {
      return false;
    }
    pr.show();
    try {
      await PostServices.deletePost(post);
      await pr.hide();
      if (post.type == PostType.offer) {
        offersRefreshKey.currentState?.show();
      } else {
        requestsRefreshKey.currentState?.show();
      }
      await AlertDialogBox.showAlert(context, message: "post_deleted_successfully".translate);
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
