import 'package:flutter/material.dart';
import 'package:freej/app/posts/models/post.dart';

import '../../../../core/exports/core.dart';
import '../../../home/components/post_card.dart';
import '../../controllers/personal_posts_view_controller.dart';

class MyRequestsTab extends StatefulWidget {
  final MyPostsViewController controller;
  const MyRequestsTab({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<MyRequestsTab> createState() => _MyRequestsTabState();
}

class _MyRequestsTabState extends State<MyRequestsTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: widget.controller.getAllRequests(),
      builder: (context, posts) {
        if (!posts.hasData || posts.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else if (!posts.hasData || (posts.data?.isEmpty ?? true)) {
          return Center(child: FullScreenBanner("no_requests_available".translate));
        }
        return RefreshIndicator(
          key: widget.controller.requestsRefreshKey,
          onRefresh: () => widget.controller.getAllRequests(refresh: true).then((value) => setState(() {})),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.xl),
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: SeparatedColumn(
              separator: const Divider(color: kTransparent),
              children: List.generate(
                posts.data!.length,
                (index) => PostCard(
                  post: (posts.data![index]),
                  onTap: () {},
                ),
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}
