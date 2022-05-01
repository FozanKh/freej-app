import 'package:flutter/material.dart';
import 'package:freej/app/notification/models/notifications.dart';
import 'package:freej/app/notification/views/notifications_view.dart';

import '../../../core/constants/phosphor_icons.dart';
import '../../../core/exports/core.dart';
import '../../auth/models/user.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final User user;
  const HomeAppBar({Key? key, required this.height, required this.user}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: MediaQuery.of(context).padding.top, right: Insets.m, left: Insets.m, bottom: Insets.m),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.name,
                style: TextStyles.t1,
              ),
              // Add user.building.number
              Text(
                '${'your_are_in_building'.translate} ${user.building.name}',
                style: TextStyles.caption.copyWith(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Nav.openPage(context: context, page: const NotificationsView()),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(Insets.m),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryColorLight,
              ),
              child: const Icon(
                PhosphorIcons.bell_fill,
                color: kPrimaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
