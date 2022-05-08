import 'package:flutter/material.dart';
import 'package:freej/core/exports/core.dart';
import 'package:freej/core/services/local/shared_pref.dart';

import '../components/notification_card.dart';
import '../controllers/notifications_view_controller.dart';
import '../models/notifications.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  bool loadingCompleted = false;
  late final NotificationsViewController controller;

  @override
  void initState() {
    SharedPreference.instance.setLastNotificationCheck();
    controller = NotificationsViewController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notifications'.translate),
      ),
      body: FutureBuilder<List<Notifications>>(
        future: controller.getAllNotifications(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || (snapshot.data?.isEmpty ?? true)) {
            RefreshIndicator(
              onRefresh: () async => controller.getAllNotifications(refresh: true).then((value) => setState(() {})),
              child: SizedBox.expand(
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    child: Center(child: FullScreenBanner("no_notifications_yet_alert".translate))),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => controller.getAllNotifications(refresh: true).then((value) => setState(() {})),
            child: SizedBox.expand(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.xl),
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: SeparatedColumn(
                  separator: const Divider(color: kTransparent),
                  children: List.generate(
                    snapshot.data!.length,
                    (index) => NotificationCard(notification: snapshot.data![index]),
                  ).toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
