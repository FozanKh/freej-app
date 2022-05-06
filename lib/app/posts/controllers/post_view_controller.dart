import 'package:flutter/material.dart';
import 'package:freej/app/posts/post_repository.dart';
import 'package:freej/app/posts/services/post_services.dart';

import '../../../core/components/bottom_sheet.dart';
import '../../../core/exports/core.dart';
import '../models/post.dart';
import '../view/add_review_view.dart';

class PostViewController {
  final BuildContext context;
  final Post post;
  late final ProgressDialog pr;

  PostViewController(this.context, this.post) {
    pr = ProgressDialog(context);
  }

  String get actionButtonTitle {
    if (post.applicationStatus == PostApplicationStatus.unknown) {
      return 'order'.translate;
    } else {
      return post.applicationStatus.toString().translate;
    }
  }

  bool get isButtonEnabled {
    switch (post.applicationStatus) {
      case PostApplicationStatus.unknown:
        return true; // can order
      default:
        return false;
    }
  }

  Color get actionButtonColor {
    return kPrimaryColor;
  }

  VoidCallback get actionButtonOnTap {
    switch (post.applicationStatus) {
      case PostApplicationStatus.unknown:
        return () async => await applyForPost();
      default:
        return () {};
    }
  }

  Future<void> applyForPost() async {
    try {
      await pr.show();
      await PostServices.applyForPost(post);
      post.type == PostType.offer
          ? await PostRepository.instance.getOffers(refresh: true)
          : await PostRepository.instance.getRequests(refresh: true);
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "application_done_successfully".translate);
      Nav.popPage(context);
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
  }

  Future<void> cancelApplication() async {
    if (post.myApplication(context) == null) {
      await AlertDialogBox.showAlert(context, message: "no_application_found".translate);
      return;
    }
    try {
      await pr.show();
      await PostServices.cancelPostApplication(post, post.myApplication(context)!);
      post.type == PostType.offer
          ? await PostRepository.instance.getOffers(refresh: true)
          : await PostRepository.instance.getRequests(refresh: true);
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "cancellation_done_successfully".translate);
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
  }

  Future<void> acceptApplication(PostApplication application) async {
    try {
      await pr.show();
      await PostServices.acceptPostApplication(post, application);
      post.type == PostType.offer
          ? await PostRepository.instance.getOffers(refresh: true)
          : await PostRepository.instance.getRequests(refresh: true);
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "acceptance_done_successfully".translate);
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
  }

  Future<void> rejectApplication(PostApplication application) async {
    try {
      await pr.show();
      await PostServices.cancelPostApplication(post, application);
      post.type == PostType.offer
          ? await PostRepository.instance.getOffers(refresh: true)
          : await PostRepository.instance.getRequests(refresh: true);
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "rejection_done_successfully".translate);
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
  }

  Future<void> completeApplication(PostApplication application) async {
    try {
      await pr.show();
      await PostServices.cancelPostApplication(post, application);
      post.type == PostType.offer
          ? await PostRepository.instance.getOffers(refresh: true)
          : await PostRepository.instance.getRequests(refresh: true);
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "completion_done_successfully".translate);
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
  }

  Future<void> startAddingReview() async {
    await showCustomBottomSheet(context, child: AddReviewView(callback: addReview), title: 'create_request'.translate);
  }

  Future<bool> addReview(int rating, String comment) async {
    try {
      await pr.show();
      await PostServices.addReview(post, rating, comment);
      post.type == PostType.offer
          ? await PostRepository.instance.getOffers(refresh: true)
          : await PostRepository.instance.getRequests(refresh: true);
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: translateText("review_added_successfully"));
      return true;
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
      return false;
    }
  }

  Future<void> switchPostActivation() async {
    try {
      await pr.show();
      await PostServices.deactivatePost(post, !post.isActive);
      post.type == PostType.offer
          ? await PostRepository.instance.getOffers(refresh: true)
          : await PostRepository.instance.getRequests(refresh: true);
      await pr.hide();
      if (post.isActive) {
        await AlertDialogBox.showAlert(context, message: "deactivation_done_successfully".translate);
      } else {
        await AlertDialogBox.showAlert(context, message: "activation_done_successfully".translate);
      }
      Nav.popPage(context, args: true);
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
  }
}
