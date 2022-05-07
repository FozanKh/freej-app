import 'package:flutter/material.dart';
import 'package:freej/app/notification/repositories/notifications_repository.dart';
import 'package:freej/app/notification/views/notifications_view.dart';

import '../../../core/constants/phosphor_icons.dart';
import '../../../core/exports/core.dart';
import '../../auth/models/user.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final User user;
  const HomeAppBar({Key? key, required this.height, required this.user}) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
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
                widget.user.name,
                style: TextStyles.t1,
              ),
              // Add user.building.number
              Text(
                '${'your_are_in_building'.translate} ${widget.user.building.name}',
                style: TextStyles.caption.copyWith(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Stack(
            children: [
              GestureDetector(
                onTap: () =>
                    Nav.openPage(context: context, page: const NotificationsView()).then((value) => setState(() {})),
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kPrimaryColorLight,
                  ),
                  child: Stack(
                    alignment: Alignment.topRight.relative(),
                    children: [
                      FutureBuilder<bool>(
                        future: NotificationsRepository.instance.showNotificationBadge(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data == true) {
                            return Container(
                              height: 15,
                              width: 15,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: kRed2,
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.all(Insets.m),
                        child: Icon(
                          PhosphorIcons.bell_fill,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
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
