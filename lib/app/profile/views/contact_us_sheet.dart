import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:freej/core/exports/core.dart';

import '../../../core/constants/phosphor_icons.dart';
import '../../../core/util/services.dart';

class ContactUsSheet extends StatefulWidget {
  const ContactUsSheet({Key? key}) : super(key: key);

  @override
  State<ContactUsSheet> createState() => _ContactUsSheetState();
}

class _ContactUsSheetState extends State<ContactUsSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Bounce(
          onTap: () => UtilitiesServices.contactFreej(context, whatsapp: true),
          child: Container(
            padding: const EdgeInsets.all(Insets.m),
            child: Row(
              children: [
                const Expanded(
                  child: Icon(PhosphorIcons.whatsapp_logo_light, size: 75, color: kWhite),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Whatsapp',
                    style: TextStyles.t2.withColor(kWhite),
                  ),
                ),
              ],
            ),
            decoration: const BoxDecoration(
              borderRadius: Borders.mBorderRadius,
              color: kPrimaryColor,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Bounce(
          onTap: () => UtilitiesServices.contactFreej(context, whatsapp: false),
          child: Container(
            padding: const EdgeInsets.all(Insets.m),
            child: Row(
              children: [
                const Expanded(
                  child: Icon(PhosphorIcons.envelope_simple_light, size: 75, color: kWhite),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: Text(
                    'email'.translate,
                    style: TextStyles.t2.withColor(kWhite),
                  ),
                ),
              ],
            ),
            decoration: const BoxDecoration(
              borderRadius: Borders.mBorderRadius,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
