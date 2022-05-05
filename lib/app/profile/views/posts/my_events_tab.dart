import 'package:flutter/material.dart';
import 'package:freej/app/home/components/event_card.dart';

import '../../../../core/exports/core.dart';
import '../../../events/models/event.dart';
import '../../controllers/my_posts_view_controller.dart';

class MyEventsTab extends StatefulWidget {
  final MyPostsViewController controller;
  const MyEventsTab({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<MyEventsTab> createState() => _MyEventsTabState();
}

class _MyEventsTabState extends State<MyEventsTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Event>>(
      future: widget.controller.getMyEvents(),
      builder: (context, events) {
        if (!events.hasData || events.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else if (!events.hasData || (events.data?.isEmpty ?? true)) {
          return Center(child: FullScreenBanner("no_events_available".translate));
        }
        return RefreshIndicator(
          key: widget.controller.eventsRefreshKey,
          onRefresh: () => widget.controller.getMyEvents(refresh: true).then((value) => setState(() {})),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.xl),
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              child: SeparatedColumn(
                separator: const Divider(color: kTransparent),
                children: List.generate(
                  events.data!.length,
                  (index) => EventCard(
                    event: (events.data![index]),
                    editEventCallback: widget.controller.startEditingEvent,
                    onTap: () {},
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
