import 'package:flutter/material.dart';

import '../../../core/exports/core.dart';
import '../../events/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback joinEventCallback;

  const EventCard({Key? key, required this.event, required this.joinEventCallback}) : super(key: key);
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
                    event.name,
                    style: TextStyles.h2.withWeight(FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    //TODO: add host name
                    event.host.toString(),
                    style: TextStyles.body3,
                  ),
                  const SizedBox(height: 16),
                  Text(event.description),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RoundedButton(
                        onTap: joinEventCallback,
                        title: "join".translate,
                        textStyle: TextStyles.body2.withColor(kGreen).withWeight(FontWeight.w600),
                        shrink: true,
                        buttonColor: kWhite,
                        margin: EdgeInsets.zero,
                        padding: const EdgeInsets.symmetric(horizontal: Insets.xxl, vertical: Insets.s),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      const SizedBox(width: Insets.xl),
                      Text(
                        "${event.date.dMMM}, ${event.date.eeee}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
