import 'package:flutter/material.dart';
import 'package:freej/app/posts/models/post.dart';

import '../../../../core/exports/core.dart';
import '../../../posts/view/post_view.dart';
import '../../components/post_card.dart';
import '../../controllers/home_view_controller.dart';

class RequestsTab extends StatefulWidget {
  final HomeViewController controller;
  const RequestsTab({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<RequestsTab> createState() => _RequestsTabState();
}

class _RequestsTabState extends State<RequestsTab> {
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
          onRefresh: () async => widget.controller.getAllRequests(refresh: true).then((value) => setState(() {})),
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
                    orderCallback: () async => Nav.openPage(context: context, page: PostView(post: posts.data![index]))
                        .then((value) => setState(() {})),
                    onTap: () async => Nav.openPage(context: context, page: PostView(post: posts.data![index]))
                        .then((value) => setState(() {})),
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
