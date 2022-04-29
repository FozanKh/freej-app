import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freej/app/profile/controllers/post_applications_controller.dart';
import 'package:freej/core/exports/core.dart';

import '../../posts/models/post.dart';

class PostApplicationsView extends StatefulWidget {
  final Post post;
  const PostApplicationsView(this.post, {Key? key}) : super(key: key);

  @override
  State<PostApplicationsView> createState() => _PostApplicationsViewState();
}

class _PostApplicationsViewState extends State<PostApplicationsView> {
  late final PostApplicationsViewController controller;

  @override
  void initState() {
    controller = PostApplicationsViewController(context, widget.post);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("applications".translate), elevation: 0.5),
      body: widget.post.applications!.isEmpty
          ? Center(child: FullScreenBanner("no_applications_yet".translate))
          : SingleChildScrollView(
              child: SeparatedColumn(
                separator: const Divider(),
                trailingSeparator: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.m),
                children: widget.post.applications!
                    .map(
                      (e) => Row(
                        children: [
                          Expanded(
                            // flex: ,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${e.beneficiary.firstName}",
                                  style: TextStyles.h2,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${e.beneficiary.mobileNumber}",
                                  style: TextStyles.h2,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: e.statusColor, width: 2),
                                    borderRadius: Borders.mBorderRadius,
                                    color: e.statusColor.withOpacity(0.2),
                                  ),
                                  child: Text(
                                    e.status.toString().translate,
                                    style: TextStyles.body1.withColor(e.statusColor).withWeight(FontWeight.bold),
                                  ),
                                ),
                                if (e.status == PostApplicationStatus.pending)
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RoundedButton(
                                          title: "accept".translate,
                                          buttonColor: kGreen,
                                          padding: EdgeInsets.zero,
                                          onTap: () async => controller.acceptApplication(e),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: RoundedButton(
                                          title: "reject".translate,
                                          padding: EdgeInsets.zero,
                                          buttonColor: kRed2,
                                          onTap: () async => controller.rejectApplication(e),
                                        ),
                                      ),
                                    ],
                                  )
                                else if (e.status == PostApplicationStatus.accepted)
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RoundedButton(
                                          title: "complete".translate,
                                          padding: EdgeInsets.zero,
                                          buttonColor: kBlue,
                                          onTap: () async => controller.completeApplication(e),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: RoundedButton(
                                          title: "cancel".translate,
                                          padding: EdgeInsets.zero,
                                          buttonColor: kRed2,
                                          onTap: () async => controller.cancelApplication(e),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}
