import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/exports/core.dart';
import '../../../auth/models/user.dart';
import '../../../posts/models/post.dart';
import '../../components/post_card.dart';
import '../../controllers/home_view_controller.dart';

class OffersTab extends StatefulWidget {
  final HomeViewController controller;
  const OffersTab({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<OffersTab> createState() => _OffersTabState();
}

class _OffersTabState extends State<OffersTab> {
  late User user;

  @override
  void didChangeDependencies() {
    user = context.read<User>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: widget.controller.getAllOffers(),
      builder: (context, posts) {
        if (!posts.hasData || posts.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else if (!posts.hasData || (posts.data?.isEmpty ?? true)) {
          return Center(child: FullScreenBanner("no_offers_available".translate));
        }
        List<Post> refinedPosts = posts.data!.where(((e) => e.owner.id != user.id)).toList();
        if (refinedPosts.isEmpty) {
          return Center(child: FullScreenBanner("no_offers_available".translate));
        }
        return RefreshIndicator(
          key: widget.controller.offersRefreshKey,
          onRefresh: () => widget.controller.getAllOffers(refresh: true).then((value) => setState(() {})),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.xl),
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: SeparatedColumn(
              separator: const Divider(color: kTransparent),
              children: List.generate(
                refinedPosts.length,
                (index) => PostCard(
                  post: (refinedPosts[index]),
                  orderCallback: () {},
                ),
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}
