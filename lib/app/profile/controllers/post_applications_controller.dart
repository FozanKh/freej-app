import 'package:flutter/material.dart';

import '../../../core/exports/core.dart';
import '../../posts/models/post.dart';
import '../../posts/post_repository.dart';
import '../../posts/services/post_services.dart';

class PostApplicationsViewController {
  final BuildContext context;
  final Post post;
  late final ProgressDialog pr;

  PostApplicationsViewController(this.context, this.post) {
    pr = ProgressDialog(context);
  }

  Future<void> acceptApplication(PostApplication application) async {
    if (!(await AlertDialogBox.showAssertionDialog(context,
            message: translateText('assurance_alert', arguments: ['accept_application'])) ??
        false)) return;
    try {
      await pr.show();
      await PostServices.acceptPostApplication(post, application);
      await Future.wait([
        PostRepository.instance.getOffers(refresh: true),
        PostRepository.instance.getRequests(refresh: true),
      ]);
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "application_accepted_successfully");
      Nav.popPage(context, args: true);
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
  }

  Future<void> rejectApplication(PostApplication application) async {
    if (!(await AlertDialogBox.showAssertionDialog(context,
            message: translateText('assurance_alert', arguments: ['reject_application'])) ??
        false)) return;
    try {
      await pr.show();
      await PostServices.rejectPostApplication(post, application);
      await Future.wait([
        PostRepository.instance.getOffers(refresh: true),
        PostRepository.instance.getRequests(refresh: true),
      ]);
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "application_rejected_successfully");
      Nav.popPage(context, args: true);
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
  }

  Future<void> completeApplication(PostApplication application) async {
    if (!(await AlertDialogBox.showAssertionDialog(context,
            message: translateText('assurance_alert', arguments: ['complete_application'])) ??
        false)) return;
    try {
      await pr.show();
      await PostServices.completePostApplication(post, application);
      await Future.wait([
        PostRepository.instance.getOffers(refresh: true),
        PostRepository.instance.getRequests(refresh: true),
      ]);
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "application_completed_successfully");
      Nav.popPage(context, args: true);
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
  }

  Future<void> cancelApplication(PostApplication application) async {
    if (!(await AlertDialogBox.showAssertionDialog(context,
            message: translateText('assurance_alert', arguments: ['cancel_application'])) ??
        false)) return;
    try {
      await pr.show();
      await PostServices.cancelPostApplication(post, application);
      await Future.wait([
        PostRepository.instance.getOffers(refresh: true),
        PostRepository.instance.getRequests(refresh: true),
      ]);
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: "application_canceled_successfully");
      Nav.popPage(context, args: true);
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
  }
}
