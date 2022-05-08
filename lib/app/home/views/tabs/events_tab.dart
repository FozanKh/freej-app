import 'package:flutter/material.dart';

import '../../../../core/exports/core.dart';
import '../../../events/models/event.dart';
import '../../components/event_card.dart';
import '../../controllers/home_view_controller.dart';

class EventsTab extends StatefulWidget {
  final HomeViewController controller;
  const EventsTab({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Event>>(
      future: widget.controller.getAllEvents(),
      builder: (context, events) {
        if (!events.hasData || events.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else if (!events.hasData || (events.data?.isEmpty ?? true)) {
          RefreshIndicator(
            onRefresh: () async => widget.controller.getAllEvents(refresh: true).then((value) => setState(() {})),
            child: SizedBox.expand(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                child: Center(child: FullScreenBanner("no_events_available".translate)),
              ),
            ),
          );
        }
        return RefreshIndicator(
          key: widget.controller.eventsRefreshKey,
          onRefresh: () async => widget.controller.getAllEvents(refresh: true).then((value) => setState(() {})),
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
                    onTap: () {},
                    joinEventCallback: () => events.data![index].isJoined
                        ? widget.controller.leaveEvent(events.data![index]).then((value) => setState(() {}))
                        : widget.controller.joinEvent(events.data![index]).then((value) => setState(() {})),
                    editEventCallback: widget.controller.startEditingEvent,
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
