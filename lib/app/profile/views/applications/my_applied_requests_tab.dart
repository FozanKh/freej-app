import 'package:flutter/material.dart';
import 'package:freej/app/posts/models/post.dart';

import '../../../../core/exports/core.dart';
import '../../../home/components/post_card.dart';
import '../../controllers/my_applications_view_controller.dart';
import '../my_post_view.dart';

class MyAppliedRequestsTab extends StatefulWidget {
  final MyApplicationsViewController controller;
  const MyAppliedRequestsTab({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<MyAppliedRequestsTab> createState() => _MyAppliedRequestsTabState();
}

class _MyAppliedRequestsTabState extends State<MyAppliedRequestsTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: widget.controller.getMyAppliedRequests(),
      builder: (context, posts) {
        if (!posts.hasData || posts.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else if (!posts.hasData || (posts.data?.isEmpty ?? true)) {
          return Center(child: FullScreenBanner("no_requests_available".translate));
        }
        return RefreshIndicator(
          key: widget.controller.requestsRefreshKey,
          onRefresh: () => widget.controller.getMyAppliedRequests(refresh: true).then((value) => setState(() {})),
          child: SizedBox.expand(
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
                    // onTap: () async => Nav.openPage(context: context, page: MyPostView(post: posts.data![index]))
                    //     .then((value) => setState(() {})),
                    editCallback: widget.controller.startEditingPost,
                  ),
                ).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
