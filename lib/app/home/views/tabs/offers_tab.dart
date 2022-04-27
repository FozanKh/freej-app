import 'package:flutter/material.dart';

import '../../../../core/exports/core.dart';
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
          onRefresh: () => widget.controller.getAllOffers(refresh: true).then((value) => setState(() {})),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.xl),
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: SeparatedColumn(
              separator: const Divider(color: kTransparent),
              children: List.generate(
                posts.data!.length,
                (index) => PostCard(
                  post: (posts.data![index]),
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
