import 'package:flutter/material.dart';
import 'package:freej/core/constants/phosphor_icons.dart';
import 'package:freej/core/exports/core.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);
  // final Post post;

  // const PostCard({Key? key, required this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.xxlCardHeight * 1.75,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: Borders.mBorderRadius,
        color: kPrimaryColorLight,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.kFreejLogoAsset,
            height: MediaQuery.of(context).size.height / 5,
          ),
          // const Icon(
          //   PhosphorIcons.warning_circle_fill,
          //   color: kRed2,
          // ),
          // const Text('post.title'),
          // const Text('post.description'),
          // Row(
          //   children: [
          //     Expanded(
          //       child: RoundedButton(
          //         title: 'order'.translate,
          //         onTap: () {},
          //       ),
          //     ),
          //     Expanded(
          //       child: Titled(
          //         title: 'availability'.translate,
          //         child: const Text('From 15:00 to 18:00'),
          //       ),
          //     ),
          //     Expanded(
          //       child: Titled(
          //         title: 'date_added'.translate,
          //         child: Text(DateTime.now().dateString),
          //       ),
          //     )
          //       ],
          //     )
        ],
      ),
    );
  }
}
