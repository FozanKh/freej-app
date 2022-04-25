import 'package:flutter/material.dart';
import 'package:freej/core/exports/core.dart';

import '../../../core/components/expandable_picker.dart';
import '../models/maintenance_issue.dart';

class CreateMaintenanceIssueView extends StatefulWidget {
  final Function callback;
  const CreateMaintenanceIssueView({Key? key, required this.callback}) : super(key: key);

  @override
  State<CreateMaintenanceIssueView> createState() => _CreateMaintenanceIssueViewState();
}

class _CreateMaintenanceIssueViewState extends State<CreateMaintenanceIssueView> {
  MaintenanceIssueType? type;
  String description = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Titled(
          title: 'maintenance_issue_type'.translate,
          child: ExpandablePicker(
            title: 'type'.translate,
            options: MaintenanceIssueType.values.map((e) => e.toString().translate).toList(),
            value: type?.toString().translate,
            callback: (index) {
              type = MaintenanceIssueType.values[index];
              setState(() {});
            },
          ),
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
            if (type == null) {
              AlertDialogBox.showAlert(context, message: 'please_choose_issue_type');
            } else if (description.length < 5) {
              AlertDialogBox.showAlert(context, message: 'please_enter_proper_description');
            } else if (await widget.callback(type, description)) {
              Nav.popPage(context);
            }
          },
        )
      ],
    );
  }
}
