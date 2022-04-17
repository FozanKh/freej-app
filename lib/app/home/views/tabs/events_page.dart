import 'package:flutter/material.dart';

import '../../../../core/exports/core.dart';
import '../../../events/models/event.dart';
import '../../components/event_card.dart';
import '../../controllers/home_view_controller.dart';

class EventsTab extends StatelessWidget {
  final HomeViewController controller;
  const EventsTab({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Event>>(
      future: controller.getAllEvents(),
      builder: (context, events) {
        if (!events.hasData || (events.data?.isEmpty ?? true)) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Insets.l, vertical: Insets.xl),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: SeparatedColumn(
              separator: const Divider(color: kTransparent),
              children: List.generate(
                events.data!.length,
                (index) => EventCard(
                  event: (events.data![index]),
                  joinEventCallback: () => controller.joinEvent(events.data![index]),
                ),
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}
