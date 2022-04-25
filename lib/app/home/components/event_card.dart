import 'package:flutter/material.dart';
import 'package:freej/core/constants/phosphor_icons.dart';
import '../../../core/exports/core.dart';
import '../../events/models/event.dart';

class EventCard extends StatefulWidget {
  final Event event;
  final VoidCallback joinEventCallback;
  final Function editEventCallback;

  const EventCard({Key? key, required this.event, required this.joinEventCallback, required this.editEventCallback})
      : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool showDeleteButton = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: kWhite),
      child: Container(
        height: Sizes.xxlCardHeight,
        decoration: BoxDecoration(
          color: kGreen,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(Assets.kWavesAsset, height: Sizes.xxlCardHeight),
            ),
            Padding(
              padding: const EdgeInsets.all(Insets.l),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.event.name,
                    style: TextStyles.h2.withWeight(FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    //TODO: add host name
                    widget.event.host.toString(),
                    style: TextStyles.body3,
                  ),
                  const SizedBox(height: 16),
                  Text(widget.event.description),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RoundedButton(
                        onTap: widget.joinEventCallback,
                        title: widget.event.isJoined ? "leave".translate : "join".translate,
                        textStyle: TextStyles.body2
                            .withColor(widget.event.isJoined ? kRed2 : kGreen)
                            .withWeight(FontWeight.w600),
                        shrink: true,
                        buttonColor: kWhite,
                        margin: EdgeInsets.zero,
                        padding: const EdgeInsets.symmetric(horizontal: Insets.xxl, vertical: Insets.s),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      const SizedBox(width: Insets.xl),
                      Text(
                        "${widget.event.date.dMMM}, ${widget.event.date.eeee}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // if ((context.read<User>().isSupervisor ?? false) && widget.announcement.type == AnnouncementType.building)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight.relative(),
                child: AnimatedCrossFade(
                  crossFadeState: showDeleteButton ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  firstChild: Bounce(
                    onTap: () => setState(() => showDeleteButton = true),
                    child: const Icon(PhosphorIcons.dots_three_vertical_bold, color: kWhite),
                  ),
                  secondChild: ActionButton(
                    title: 'edit',
                    color: kSecondaryColor.withOpacity(0.5),
                    onTap: () async {
                      await widget.editEventCallback(widget.event);
                      showDeleteButton = false;
                      if (mounted) setState(() => {});
                    },
                  ),
                  duration: const Duration(milliseconds: 200),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
