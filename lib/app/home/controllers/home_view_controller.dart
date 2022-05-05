import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freej/app/events/repositories/event_repository.dart';
import 'package:freej/app/posts/services/post_services.dart';
import 'package:freej/app/profile/views/edit_profile_view.dart';
import 'package:freej/core/exports/core.dart';
import 'package:freej/core/services/firebase/storage_services.dart';
import 'package:provider/provider.dart';
import '../../../core/components/bottom_sheet.dart';
import '../../../core/constants/phosphor_icons.dart';
import '../../auth/models/user.dart';
import '../../events/models/event.dart';
import '../../events/services/event_services.dart';
import '../../events/views/create_event_view.dart';
import '../../events/views/edit_event_view.dart';
import '../../posts/models/post.dart';
import '../../posts/post_repository.dart';
import '../../posts/view/create_post_view.dart';

class HomeViewController {
  final BuildContext context;
  late ProgressDialog pr;
  late final TabController tabController;
  late final GlobalKey<RefreshIndicatorState> eventsRefreshKey;
  late final GlobalKey<RefreshIndicatorState> offersRefreshKey;
  late final GlobalKey<RefreshIndicatorState> requestsRefreshKey;

  HomeViewController(this.context, state) {
    pr = ProgressDialog(context);
    tabController = TabController(length: 3, vsync: state);
    tabController.addListener(() {
      state.setState(() {});
    });
    eventsRefreshKey = GlobalKey<RefreshIndicatorState>();
    offersRefreshKey = GlobalKey<RefreshIndicatorState>();
    requestsRefreshKey = GlobalKey<RefreshIndicatorState>();
  }

  FloatingActionButton get homeFloatingActionButton => FloatingActionButton(
        backgroundColor: [
          kPrimaryColor,
          kBlue,
          kGreen,
        ][tabController.index],
        child: const Icon(PhosphorIcons.plus_bold, size: 30),
        onPressed: () async => fabAction,
      );

  Future<VoidCallback> get fabAction async {
    if (!context.read<User>().completedProfile) {
      if (await AlertDialogBox.showAssertionDialog(context, message: 'complete_profile_first') ?? false) {
        await Nav.openPage(context: context, page: const EditProfileView());
      }
      if (!context.read<User>().completedProfile) {
        return () {};
      }
    }

    switch (tabController.index) {
      case 0:
        return await showCustomBottomSheet(context,
            child: CreatePostView(callback: createPost, type: PostType.request), title: 'create_request'.translate);
      case 1:
        return await showCustomBottomSheet(context,
            child: CreatePostView(callback: createPost, type: PostType.offer), title: 'create_offer'.translate);
      case 2:
        return await showCustomBottomSheet(context,
            child: CreateEventView(callback: createEvent), title: 'create_event'.translate);
      default:
        return () {};
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

  Future<List<Post>> getAllOffers({refresh = false}) async {
    try {
      List<Post> posts = await PostRepository.instance.getOffers(refresh: refresh);
      List<Post> refinedPosts = posts.where(((e) => e.owner.id != context.read<User>().id)).toList();
      return refinedPosts;
    } catch (e) {
      AlertDialogBox.showAlert(context, message: e.toString().translate);
    }
    return [];
  }

  Future<List<Post>> getAllRequests({refresh = false}) async {
    try {
      List<Post> posts = await PostRepository.instance.getRequests(refresh: refresh);
      List<Post> refinedPosts = posts.where(((e) => e.owner.id != context.read<User>().id)).toList();
      return refinedPosts;
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
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "event_joined_successfully".translate);
      await eventsRefreshKey.currentState?.show();
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
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "event_left_successfully".translate);
      await eventsRefreshKey.currentState?.show();
    } catch (e) {
      eventsRefreshKey.currentState?.show();
      pr.hide();
      AlertDialogBox.showAlert(context, message: e.toString().translate);
    }
  }

  Future<bool> createPost(PostType type, String title, String description, List<File> images) async {
    pr.show();
    try {
      List<String> imagesUrls = [];
      int counter = 1;
      for (var image in images) {
        String? url = await StorageServices.uploadFile(
          file: image,
          ref:
              'users/${context.read<User>().id}/posts/${type.name}/images/$title-$counter-${DateTime.now().millisecondsSinceEpoch}.'
                  .toLowerCase(),
        );
        counter++;
        if (url != null) {
          imagesUrls.add(url);
        }
      }
      await PostServices.createPost(title, description, imagesUrls, type);

      if (type == PostType.offer) {
        await getAllOffers(refresh: true);
        await offersRefreshKey.currentState?.show();
      } else {
        await getAllEvents(refresh: true);
        await requestsRefreshKey.currentState?.show();
      }

      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "offer_created_successfully".translate);
      return true;
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString().translate);
      return false;
    }
  }

  Future<bool> createEvent(String name, EventType type, String description, DateTime date, {int? id}) async {
    pr.show();
    try {
      await EventServices.createEvent(name, type, description, date);
      await eventsRefreshKey.currentState?.show();
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
        child: EditEventView(callback: editEvent, deleteCallback: deleteEvent, event: event),
        title: 'edit_event'.translate);
  }

  Future<bool> editEvent(String name, EventType type, String description, DateTime date, {int? id}) async {
    pr.show();
    try {
      if (id == null) {
        await pr.hide();
        return false;
      }
      await EventServices.editEvent(id, name, type, description, date);
      await eventsRefreshKey.currentState?.show();
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
