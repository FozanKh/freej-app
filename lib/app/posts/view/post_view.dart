import 'package:flutter/material.dart';
import 'package:freej/app/posts/controllers/post_view_controller.dart';

import '../../../core/constants/phosphor_icons.dart';
import '../../../core/exports/core.dart';
import '../models/post.dart';

class PostView extends StatefulWidget {
  final Post post;
  const PostView({Key? key, required this.post}) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  bool showFullImage = false;
  late PostViewController controller;

  @override
  void initState() {
    controller = PostViewController(context, widget.post);
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
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Text('order'.translate, style: TextStyles.callOut.withColor(kWhite).withWeight(FontWeight.bold)),
              //   ],
              // ),
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
                padding: const EdgeInsets.only(top: 210, bottom: Insets.m),
                decoration: const BoxDecoration(
                  borderRadius: Borders.mBorderRadius,
                  boxShadow: Styles.boxShadow,
                  color: Colors.white,
                ),
                child: SeparatedColumn(
                  separator: const Divider(thickness: 1, height: 40),
                  contentPadding: const EdgeInsets.only(right: Insets.m, left: Insets.m),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.title,
                          style: TextStyles.h1.withWeight(FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(widget.post.description, style: TextStyles.body1),
                      ],
                    ),
                    Titled(
                      title: "by".translate,
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.post.owner.firstName ?? '',
                                style: TextStyles.h2.withWeight(FontWeight.bold),
                              ),
                              const SizedBox(width: 10),
                              Text("(${widget.post.owner.numberOfRaters}) ${widget.post.owner.stars}",
                                  style: TextStyles.h2),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Titled(
                            title: "contacts".translate,
                            padding: EdgeInsets.zero,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("building".translate, style: TextStyles.body1.withWeight(FontWeight.bold)),
                                const SizedBox(height: 5),
                                Text(widget.post.owner.building!, style: TextStyles.body2),
                                if (widget.post.applicationStatus == PostApplicationStatus.accepted)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 15),
                                      Text("phone_number".translate,
                                          style: TextStyles.body1.withWeight(FontWeight.bold)),
                                      const SizedBox(height: 5),
                                      Text(widget.post.owner.mobileNumber!, style: TextStyles.body2),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.post.reviews?.isNotEmpty ?? false)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('reviews'.translate, style: TextStyles.t2),
                              if (widget.post.applicationStatus == PostApplicationStatus.completed)
                                Bounce(
                                  onTap: controller.startAddingReview,
                                  child: Text(
                                    "add_review".translate,
                                    style: TextStyles.callOutFocus.copyWith(
                                      decoration: TextDecoration.underline,
                                      color: kFontsColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const Divider(thickness: 1, height: 5),
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
                    else if (widget.post.applicationStatus == PostApplicationStatus.completed)
                      Bounce(
                        onTap: controller.startAddingReview,
                        child: Text(
                          "add_review".translate,
                          style: TextStyles.callOutFocus.copyWith(
                            decoration: TextDecoration.underline,
                            color: kFontsColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
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
