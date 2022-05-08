import 'package:flutter/material.dart';
import 'package:freej/core/exports/core.dart';

class CreateAnnouncementView extends StatefulWidget {
  final Function callback;
  const CreateAnnouncementView({Key? key, required this.callback}) : super(key: key);

  @override
  State<CreateAnnouncementView> createState() => _CreateAnnouncementViewState();
}

class _CreateAnnouncementViewState extends State<CreateAnnouncementView> {
  String title = '';
  String description = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedTextFormField(
          title: 'title'.translate,
          onChanged: (value) => title = value,
        ),
        const SizedBox(height: 30),
        RoundedTextFormField(
          title: 'description'.translate,
          onChanged: (value) => description = value,
          maxLines: 4,
        ),
        const SizedBox(height: 30),
        RoundedButton(
          title: "submit".translate,
          onTap: () async {
            if (title.length < 4) {
              AlertDialogBox.showAlert(context, message: 'please_enter_proper_title'.translate);
            } else if (description.length < 5) {
              AlertDialogBox.showAlert(context, message: 'please_enter_proper_description'.translate);
            } else if (await widget.callback(title, description)) {
              Nav.popPage(context);
            }
          },
        )
      ],
    );
  }
}
