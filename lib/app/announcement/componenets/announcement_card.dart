import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:freej/core/exports/core.dart';

import '../../../core/constants/phosphor_icons.dart';
import '../../auth/models/user.dart';
import '../../report/services/report_services.dart';
import '../models/announcement.dart';

class AnnouncementCard extends StatefulWidget {
  final Announcement announcement;
  final Function deleteAnnouncementCallback;
  const AnnouncementCard({
    Key? key,
    required this.announcement,
    required this.deleteAnnouncementCallback,
  }) : super(key: key);

  @override
  State<AnnouncementCard> createState() => _AnnouncementCardState();
}

class _AnnouncementCardState extends State<AnnouncementCard> {
  bool showDeleteButton = false;
  @override
  Widget build(BuildContext context) {
    return Column(
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
                widget.announcement.createdAt.dMMM,
                style: TextStyles.body2.withColor(kPrimaryColor),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: const Border(left: BorderSide(color: kPrimaryColor, width: 2)).relative(),
                    ),
                    padding:
                        const EdgeInsets.only(top: Insets.s, bottom: Insets.xxl * 1.5, left: Insets.m, right: Insets.m),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.announcement.title,
                          style: TextStyles.h2.withColor(kPrimaryColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 10).relative(),
                          child: Text(
                            widget.announcement.body,
                            style: TextStyles.body2.withColor(kHintFontsColor),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight.relative(),
                    child: AnimatedCrossFade(
                      crossFadeState: showDeleteButton ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      firstChild: Bounce(
                        onTap: () => setState(() => showDeleteButton = true),
                        child: const Icon(PhosphorIcons.dots_three_vertical_bold, color: kPrimaryColor),
                      ),
                      secondChild: (context.read<User>().isSupervisor ?? false) &&
                              widget.announcement.type == AnnouncementType.building
                          ? Bounce(
                              onTap: () async {
                                await widget.deleteAnnouncementCallback(widget.announcement);
                                showDeleteButton = false;
                                if (mounted) setState(() => {});
                              },
                              child: const Icon(Icons.clear_rounded, color: kRed2),
                            )
                          : ActionButton(
                              title: 'report'.translate,
                              color: kRed2,
                              titleColor: kWhite,
                              onTap: () async {
                                await ReportServices.createReport(widget.announcement.id, "announcement", context);
                                showDeleteButton = false;
                                if (mounted) setState(() => {});
                              },
                            ),
                      duration: const Duration(milliseconds: 200),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
