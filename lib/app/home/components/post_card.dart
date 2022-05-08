import 'package:flutter/material.dart';
import 'package:freej/app/posts/models/post.dart';
import 'package:freej/core/constants/phosphor_icons.dart';
import 'package:provider/provider.dart';
import '../../../core/exports/core.dart';
import '../../auth/models/user.dart';
import '../../report/services/report_services.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final Function? orderCallback;
  final Function? editCallback;
  final Function onTap;

  const PostCard({Key? key, required this.post, this.orderCallback, required this.onTap, this.editCallback})
      : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool showDeleteButton = false;
  Color get postColor => widget.post.type == PostType.offer ? kBlue : kPrimaryColor;
  String get postButton => widget.post.type == PostType.offer ? 'benefit' : 'serve';
  String get postButton2 => widget.post.applicationStatus.name.translate;
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: kWhite),
      child: GestureDetector(
        onTap: () async {
          if (showDeleteButton) {
            showDeleteButton = false;
          } else {
            await widget.onTap();
          }
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            color: postColor,
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: AssetImage(Assets.kWavesAsset),
              fit: BoxFit.fitWidth,
              matchTextDirection: true,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(Insets.l),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.post.title,
                      style: TextStyles.h2.withWeight(FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.post.description,
                      maxLines: 2,
                      style: TextStyles.body1,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${'by'.translate} ${widget.post.owner.firstName ?? ''} ${'at'.translate} ${widget.post.owner.building}',
                      style: TextStyles.body3,
                    ),
                    Text("(${widget.post.owner.numberOfRaters}) ${widget.post.owner.stars}", style: TextStyles.body3),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (widget.orderCallback != null)
                            RoundedButton(
                              onTap: () async => await widget.orderCallback!(),
                              title: widget.post.applicationStatus == PostApplicationStatus.unknown
                                  ? postButton.translate
                                  : postButton2.translate,
                              textStyle: TextStyles.body2
                                  .withColor(widget.post.applicationStatus == PostApplicationStatus.unknown
                                      ? postColor
                                      : kWhite.withOpacity(0.4))
                                  .withWeight(FontWeight.w600),
                              shrink: true,
                              buttonColor: widget.post.applicationStatus == PostApplicationStatus.unknown
                                  ? kWhite
                                  : kGrey.withOpacity(0.9),
                              margin: EdgeInsets.zero,
                              padding: const EdgeInsets.symmetric(horizontal: Insets.xxl, vertical: Insets.s),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          if (widget.orderCallback != null) const SizedBox(width: Insets.xl),
                          Text(
                            "${widget.post.createdAt.eeee}, ${widget.post.createdAt.dMMM}",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight.relative(),
                  child: AnimatedCrossFade(
                    crossFadeState: showDeleteButton ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    firstChild: Bounce(
                      onTap: () => setState(() => showDeleteButton = true),
                      child: const Icon(PhosphorIcons.dots_three_vertical_bold, color: kWhite),
                    ),
                    secondChild: context.read<User>().id == widget.post.owner.id && widget.editCallback != null
                        ? ActionButton(
                            title: 'edit'.translate,
                            color: kWhite,
                            titleColor: kBlue,
                            onTap: () async {
                              await widget.editCallback!(widget.post);
                              showDeleteButton = false;
                              if (mounted) setState(() => {});
                            },
                          )
                        : ActionButton(
                            title: 'report'.translate,
                            color: kRed2,
                            titleColor: kWhite,
                            onTap: () async {
                              await ReportServices.createReport(widget.post.id, "post", context);
                              showDeleteButton = false;
                              if (mounted) setState(() => {});
                            },
                          ),
                    duration: const Duration(milliseconds: 200),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
