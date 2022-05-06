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
            return Center(child: FullScreenBanner("no_notifications_yet_alert".translate));
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 50),
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) => NotificationCard(notification: snapshot.data![index]),
          );
        },
      ),
    );
  }
}
