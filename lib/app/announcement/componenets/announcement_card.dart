import 'package:flutter/material.dart';
import 'package:freej/core/exports/core.dart';

import '../models/announcement.dart';

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;
  const AnnouncementCard({Key? key, required this.announcement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: Sizes.xxlCardHeight,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.14 - (7.5 - 2) / 2,
              ),
              Container(
                height: 7.5,
                width: 7.5,
                decoration: const BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.14,
                child: Text(
                  announcement.createdAt.dMMM,
                  style: TextStyles.body2.withColor(kPrimaryColor),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: const Border(left: BorderSide(color: kPrimaryColor, width: 2)).relative(),
                  ),
                  padding:
                      const EdgeInsets.only(top: Insets.s, bottom: Insets.xxl * 1.5, left: Insets.m, right: Insets.m),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        announcement.title,
                        style: TextStyles.h2.withColor(kPrimaryColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10).relative(),
                        child: Text(
                          announcement.body,
                          style: TextStyles.body2.withColor(kHintFontsColor),
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
