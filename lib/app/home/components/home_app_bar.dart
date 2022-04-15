import 'package:flutter/material.dart';

import '../../../core/constants/phosphor_icons.dart';
import '../../../core/exports/core.dart';
import '../../auth/models/user.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final User? user;
  const HomeAppBar({Key? key, required this.height, this.user}) : super(key: key);

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
              // Add user.fullName
              Text(
                'Fozan Alkhalawi',
                style: TextStyles.t1,
              ),
              // Add user.building.number
              Text(
                '${'your_are_in_building'.translate} 822',
                style: TextStyles.caption.copyWith(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Container(
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
          )
        ],
      ),
    );
  }
}
