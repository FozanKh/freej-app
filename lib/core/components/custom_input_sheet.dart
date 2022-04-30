import 'package:flutter/material.dart';
import 'package:freej/core/components/bottom_sheet.dart';

import '../exports/core.dart';

class CustomInput {
  static Future<String?> showCustomInputSheet(context,
      {required String title, String? initialValue, String? hint}) async {
    return await showCustomBottomSheet(context,
        child: _CustomInputSheet(title: title, initialValue: initialValue, hint: hint), title: title);
  }
}

class _CustomInputSheet extends StatefulWidget {
  final String title;
  final String? hint;
  final String? initialValue;
  const _CustomInputSheet({Key? key, required this.title, this.initialValue, this.hint}) : super(key: key);

  @override
  State<_CustomInputSheet> createState() => _CustomInputSheetState();
}

class _CustomInputSheetState extends State<_CustomInputSheet> {
  String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedTextFormField(
          title: widget.title,
          onChanged: (_) => value = _,
          hint: widget.hint,
          initialValue: widget.initialValue,
        ),
        const SizedBox(height: 100),
        RoundedButton(
          title: 'done'.translate,
          onTap: () {
            if (value != null) {
              Nav.popPage(context, args: value);
            } else {
              AlertDialogBox.showAlert(context, message: 'please_enter_proper_input'.translate);
            }
          },
        ),
      ],
    );
  }
}
