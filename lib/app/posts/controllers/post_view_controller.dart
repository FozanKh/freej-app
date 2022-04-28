import 'package:flutter/material.dart';
import 'package:freej/app/posts/services/post_services.dart';

import '../../../core/exports/core.dart';
import '../models/post.dart';

class PostViewController {
  final BuildContext context;
  late final ProgressDialog pr;
  final Post post;

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
      // case PostApplicationStatus.pending:
      //   return true; //can cancel only
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
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "application_done_successfully".translate);
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
  }

  Future<void> cancelApplication() async {
    try {
      await pr.show();
      await PostServices.cancelPostApplication(post);
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "cancellation_done_successfully".translate);
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
  }

  Future<void> acceptApplication() async {
    try {
      await pr.show();
      await PostServices.acceptPostApplication(post);
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "acceptance_done_successfully".translate);
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
  }

  Future<void> rejectApplication() async {
    try {
      await pr.show();
      await PostServices.cancelPostApplication(post);
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "rejection_done_successfully".translate);
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
  }

  Future<void> completeApplication() async {
    try {
      await pr.show();
      await PostServices.cancelPostApplication(post);
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "completion_done_successfully".translate);
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
  }

  Future<void> addReview() async {}
}
