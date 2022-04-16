import 'package:flutter/material.dart';
import 'package:freej/core/exports/core.dart';

import '../models/announcement.dart';

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;
  const AnnouncementCard({Key? key, required this.announcement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.xxlCardHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            announcement.createdAt.dMMM,
            style: TextStyles.body2.withColor(kPrimaryColor),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Container(
                height: 7.5,
                width: 7.5,
                decoration: const BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
              ),
              Container(
                height: Sizes.xxlCardHeight - 7.5,
                width: 1.5,
                color: kPrimaryColor,
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  announcement.title,
                  style: TextStyles.h2.withColor(kPrimaryColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10).relative(),
                  child: Text(
                    announcement.body,
                    style: TextStyles.body2.withColor(kHintFontsColor),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
