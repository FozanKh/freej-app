import 'package:flutter/material.dart';
import 'package:freej/app/posts/models/post.dart';
import 'package:provider/provider.dart';

import '../../../../core/exports/core.dart';
import '../../../auth/models/user.dart';
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
  late User user;

  @override
  void didChangeDependencies() {
    user = context.read<User>();
    super.didChangeDependencies();
  }

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
        List<Post> refinedPosts = posts.data!.where(((e) => e.owner.id != user.id)).toList();
        if (refinedPosts.isEmpty) {
          return Center(child: FullScreenBanner("no_offers_available".translate));
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
                refinedPosts.length,
                (index) => PostCard(
                  post: refinedPosts[index],
                  orderCallback: () {},
                  // joinEventCallback: () => events.data![index].isJoined
                  //     ? widget.controller.leaveEvent(events.data![index]).then((value) => setState(() {}))
                  //     : widget.controller.joinEvent(events.data![index]).then((value) => setState(() {})),
                  // editEventCallback: widget.controller.startEditingEvent,
                ),
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}
