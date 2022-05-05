import 'package:flutter/material.dart';
import 'package:freej/app/posts/controllers/post_view_controller.dart';
import 'package:freej/app/profile/views/post_applications_view.dart';
import 'package:freej/app/profile/views/profile_view.dart';

import '../../../core/constants/phosphor_icons.dart';
import '../../../core/exports/core.dart';
import '../../posts/models/post.dart';

class MyPostView extends StatefulWidget {
  final Post post;
  const MyPostView({Key? key, required this.post}) : super(key: key);

  @override
  State<MyPostView> createState() => _MyPostViewState();
}

class _MyPostViewState extends State<MyPostView> {
  bool showFullImage = false;
  late PostViewController controller;
  late bool isActive;

  @override
  void initState() {
    controller = PostViewController(context, widget.post);
    isActive = widget.post.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomSheet: Container(
        padding: const EdgeInsets.all(Insets.m),
        decoration: const BoxDecoration(
          color: kWhite,
          boxShadow: Styles.boxShadowTop,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RoundedButton(
              margin: EdgeInsets.zero,
              enabled: controller.isButtonEnabled,
              title: controller.actionButtonTitle,
              textStyle: TextStyles.callOut.withColor(kWhite).withWeight(FontWeight.bold),
              onTap: controller.actionButtonOnTap,
            ),
            const SizedBox(height: 10),
            if (widget.post.applicationStatus == PostApplicationStatus.pending)
              RoundedButton(
                margin: EdgeInsets.zero,
                enabled: widget.post.applicationStatus == PostApplicationStatus.pending,
                title: "cancel".translate,
                textStyle: TextStyles.callOut.withColor(kWhite).withWeight(FontWeight.bold),
                buttonColor: kRed2,
                onTap: controller.cancelApplication,
              ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: Sizes.lCardHeight * 3, right: Insets.m, top: Insets.m, left: Insets.m),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 60),
                padding: const EdgeInsets.only(top: 210, right: Insets.m, left: Insets.m, bottom: Insets.m),
                decoration: const BoxDecoration(
                  borderRadius: Borders.mBorderRadius,
                  boxShadow: Styles.boxShadow,
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.post.title,
                      style: TextStyles.h1.withWeight(FontWeight.bold),
                    ),
                    const SizedBox(height: Insets.m),
                    Text(widget.post.description, style: TextStyles.body1),
                    const SizedBox(height: 30),
                    const Divider(height: Insets.l * 2),
                    ProfileOptionCard(
                      icon: PhosphorIcons.folder_open_bold,
                      title: "applications".translate,
                      onTap: () async {
                        if (await Nav.openPage(context: context, page: PostApplicationsView(widget.post)) == true) {
                          Nav.popPage(context);
                        }
                      },
                    ),
                    const Divider(height: Insets.l * 2),
                    InkWell(
                      onTap: () {
                        setState(() => isActive = !isActive);
                        controller.switchPostActivation();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(PhosphorIcons.activity_bold, color: kPrimaryColor),
                          const SizedBox(width: 20),
                          Text(
                            "active".translate,
                            style: TextStyles.h1.withColor(kPrimaryColor),
                          ),
                          const Spacer(),
                          Switch(
                            value: isActive,
                            onChanged: (value) {
                              setState(() => isActive = !isActive);
                              controller.switchPostActivation();
                            },
                            activeColor: kPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                    if (widget.post.images?.isNotEmpty ?? false) const Divider(height: Insets.l * 2),
                    if (widget.post.images?.isNotEmpty ?? false) const SizedBox(height: 30),
                    if (widget.post.reviews?.isNotEmpty ?? false)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('reviews'.translate, style: TextStyles.h1),
                          const Divider(thickness: 2),
                          const SizedBox(height: 10),
                          SeparatedColumn(
                            separator: const Divider(height: 30),
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              widget.post.reviews?.length ?? 0,
                              (index) {
                                final review = widget.post.reviews![index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("(${review.rating}) ${review.stars}", style: TextStyles.body1),
                                    const SizedBox(height: 10),
                                    Text(review.comment, style: TextStyles.body1),
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      )
                  ],
                ),
              ),
              Bounce(
                onTap: () => setState(() => showFullImage = !showFullImage),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: Insets.l),
                  decoration: const BoxDecoration(
                    boxShadow: Styles.boxShadow,
                    color: kWhite,
                    borderRadius: Borders.mBorderRadius,
                  ),
                  child: (widget.post.images?.isNotEmpty ?? false)
                      ? CachedImage(
                          url: widget.post.images?.first ?? '',
                          fit: showFullImage ? BoxFit.contain : BoxFit.fitWidth,
                          borderRadius: Borders.mBorderRadius,
                          border: Border.all(color: kWhite, width: 3),
                          errorWidget: Image.asset(
                            Assets.kKfupmCampusAsset,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : const Icon(PhosphorIcons.image, size: 100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
