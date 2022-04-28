import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/exports/core.dart';
import '../../../auth/models/user.dart';
import '../../../home/components/post_card.dart';
import '../../../posts/models/post.dart';
import '../../controllers/my_posts_view_controller.dart';

class MyOffersTab extends StatefulWidget {
  final MyPostsViewController controller;
  const MyOffersTab({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<MyOffersTab> createState() => _MyOffersTabState();
}

class _MyOffersTabState extends State<MyOffersTab> {
  late User user;

  @override
  void didChangeDependencies() {
    user = context.read<User>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: widget.controller.getMyOffers(),
      builder: (context, posts) {
        if (!posts.hasData || posts.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else if (!posts.hasData || (posts.data?.isEmpty ?? true)) {
          return Center(child: FullScreenBanner("no_offers_available".translate));
        }
        return RefreshIndicator(
          key: widget.controller.offersRefreshKey,
          onRefresh: () => widget.controller.getMyOffers(refresh: true).then((value) => setState(() {})),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.xl),
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: SeparatedColumn(
              separator: const Divider(color: kTransparent),
              children: List.generate(
                posts.data!.length,
                (index) => PostCard(
                  post: posts.data![index],
                  onTap: () {},
                  editCallback: widget.controller.startEditingPost,
                ),
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}
