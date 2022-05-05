import 'package:flutter/material.dart';
import 'package:freej/core/constants/phosphor_icons.dart';
import 'package:provider/provider.dart';
import '../../../core/exports/core.dart';
import '../../auth/models/user.dart';
import '../../events/models/event.dart';
import '../../report/services/report_services.dart';

class EventCard extends StatefulWidget {
  final Event event;
  final VoidCallback? joinEventCallback;
  final Function onTap;
  final Function editEventCallback;

  const EventCard(
      {Key? key, required this.event, this.joinEventCallback, required this.editEventCallback, required this.onTap})
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
      child: GestureDetector(
        onTap: () async {
          if (showDeleteButton) {
            showDeleteButton = false;
          } else {
            await widget.onTap();
          }
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            color: kGreen,
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: AssetImage(Assets.kWavesAsset),
              fit: BoxFit.fitWidth,
              matchTextDirection: true,
            ),
          ),
          child: Stack(
            children: [
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
                        if (widget.joinEventCallback != null)
                          RoundedButton(
                            onTap: widget.joinEventCallback!,
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
                        if (widget.joinEventCallback != null) const SizedBox(width: Insets.xl),
                        Text(
                          "${widget.event.date.eeee}, ${widget.event.date.dMMM}",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),
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
                    secondChild: context.read<User>().id == widget.event.host.id
                        ? ActionButton(
                            title: 'edit'.translate,
                            color: kSecondaryColor.withOpacity(0.5),
                            onTap: () async {
                              await widget.editEventCallback(widget.event);
                              showDeleteButton = false;
                              if (mounted) setState(() => {});
                            },
                          )
                        : ActionButton(
                            title: 'report'.translate,
                            color: kRed2,
                            titleColor: kWhite,
                            onTap: () async {
                              await ReportServices.createReport(widget.event.id, "event", context);
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
      ),
    );
  }
}
