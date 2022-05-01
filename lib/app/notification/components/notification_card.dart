import 'package:flutter/material.dart';
import 'package:freej/core/constants/phosphor_icons.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/exports/core.dart';
import '../models/notifications.dart';

class NotificationCard extends StatelessWidget {
  final Notifications notification;

  const NotificationCard({Key? key, required this.notification}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Sender name
                  Text(notification.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 5),
                  // First line of the last message
                  Text(notification.body,
                      style: const TextStyle(fontSize: 13, color: kFontsColor, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  IconText(icon: Icons.access_time, text: timeago.format(DateTime(1990))),
                  // const IconText(icon: Icons.access_time, text: "timeago.format(notification.createdAt)"),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(PhosphorIcons.bell_fill, size: 30, color: kPrimaryColor),
              ),
              const SizedBox(height: 5),
              FittedBox(
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(color: kDark4, borderRadius: Borders.sBorderRadius),
                  child: const Text(
                    'type',
                    // '${notification.type.string}',
                    style: TextStyle(fontSize: 12, color: kWhite, height: 1.1),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
