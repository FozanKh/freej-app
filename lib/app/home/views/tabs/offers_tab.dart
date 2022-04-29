import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/exports/core.dart';
import '../../../auth/models/user.dart';
import '../../../posts/models/post.dart';
import '../../../posts/view/post_view.dart';
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
        return RefreshIndicator(
          key: widget.controller.offersRefreshKey,
          onRefresh: () async => widget.controller.getAllOffers(refresh: true).then((value) => setState(() {})),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.xl),
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              child: SeparatedColumn(
                separator: const Divider(color: kTransparent),
                children: List.generate(
                  posts.data!.length,
                  (index) => PostCard(
                    post: posts.data![index],
                    orderCallback: () {},
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
