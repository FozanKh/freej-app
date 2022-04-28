import 'package:flutter/material.dart';
import 'package:freej/app/posts/models/post.dart';
import 'package:freej/core/constants/phosphor_icons.dart';
import 'package:provider/provider.dart';
import '../../../core/exports/core.dart';
import '../../auth/models/user.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final Function? orderCallback;
  final Function onTap;

  const PostCard({Key? key, required this.post, this.orderCallback, required this.onTap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool showDeleteButton = false;
  Color get postColor => widget.post.type == PostType.offer ? kBlue : kPrimaryColor;
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
            // await Nav.openPage(context: context, page: PostView(post: widget.post));
          }
          setState(() {});
        },
        child: Container(
          height: Sizes.xxlCardHeight,
          decoration: BoxDecoration(
            color: postColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(Assets.kWavesAsset, height: Sizes.xxlCardHeight),
              ),
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
                      widget.post.owner.firstName ?? '',
                      style: TextStyles.body3,
                    ),
                    const SizedBox(height: 16),
                    Text(widget.post.description),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (widget.orderCallback != null)
                          RoundedButton(
                            onTap: () async => await widget.orderCallback!(),
                            title: widget.post.applicationStatus == PostApplicationStatus.unknown
                                ? "order".translate
                                : "ordered".translate,
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
                          "${widget.post.createdAt.dMMM}, ${widget.post.createdAt.eeee}",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              if (context.read<User>().id == widget.post.owner.id)
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
                      secondChild: ActionButton(
                        title: 'edit',
                        color: kWhite,
                        titleColor: kBlue,
                        onTap: () async {
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
