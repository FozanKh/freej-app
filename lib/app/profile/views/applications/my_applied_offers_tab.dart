import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/exports/core.dart';
import '../../../auth/models/user.dart';
import '../../../home/components/post_card.dart';
import '../../../posts/models/post.dart';
import '../../controllers/my_applications_view_controller.dart';
import '../my_post_view.dart';

class MyAppliedOffersTab extends StatefulWidget {
  final MyApplicationsViewController controller;
  const MyAppliedOffersTab({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<MyAppliedOffersTab> createState() => _MyAppliedOffersTabState();
}

class _MyAppliedOffersTabState extends State<MyAppliedOffersTab> {
  late User user;

  @override
  void didChangeDependencies() {
    user = context.read<User>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: widget.controller.getMyAppliedOffers(),
      builder: (context, posts) {
        if (!posts.hasData || posts.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else if (!posts.hasData || (posts.data?.isEmpty ?? true)) {
          return Center(child: FullScreenBanner("no_offers_available".translate));
        }
        return RefreshIndicator(
          key: widget.controller.offersRefreshKey,
          onRefresh: () => widget.controller.getMyAppliedOffers(refresh: true).then((value) => setState(() {})),
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
