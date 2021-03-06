import 'package:flutter/material.dart';
import 'package:freej/core/constants/phosphor_icons.dart';
import 'package:freej/core/exports/core.dart';

import '../../../core/components/expandable_picker.dart';
import '../models/event.dart';

class CreateEventView extends StatefulWidget {
  final Function callback;
  const CreateEventView({Key? key, required this.callback}) : super(key: key);

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  String title = '';
  String description = '';
  EventType? type;
  DateTime? date;
  String? locationUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RoundedTextFormField(
          title: 'title'.translate,
          onChanged: (value) => title = value,
        ),
        const SizedBox(height: 30),
        Titled(
          title: 'event_type'.translate,
          child: ExpandablePicker(
            title: 'type'.translate,
            options: EventType.values.map((e) => e.toString().translate).toList(),
            value: type?.toString().translate,
            callback: (index) {
              type = EventType.values[index];
              setState(() {});
            },
          ),
        ),
        const SizedBox(height: 30),
        Titled(
          title: 'date'.translate,
          child: Bounce(
            onTap: pickDate,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.fromBorderSide(
                  BorderSide(color: date == null ? Colors.grey : kPrimaryColor),
                ),
                borderRadius: Borders.mBorderRadius,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date?.yMMMMdhm ?? 'date'.translate,
                    style: TextStyles.body1.copyWith(
                      color: date == null ? kFontsColor : kFontsColor.withOpacity(0.80),
                      fontWeight: date == null ? null : FontWeight.w500,
                    ),
                  ),
                  Icon(date != null ? PhosphorIcons.calendar_check : PhosphorIcons.calendar_plus)
                ],
              ),
            ),
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
            if (title.length < 4) {
              AlertDialogBox.showAlert(context, message: 'please_enter_proper_title'.translate);
            } else if (type == null) {
              AlertDialogBox.showAlert(context, message: 'please_choose_issue_type'.translate);
            } else if (description.length < 5) {
              AlertDialogBox.showAlert(context, message: 'please_enter_proper_description'.translate);
            } else if (await widget.callback(title, type, description, date)) {
              Nav.popPage(context);
            }
          },
        )
      ],
    );
  }

  Future<void> pickDate() async {
    TimeOfDay? time;
    DateTime? newDate = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) => DatePickerDialog(
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch + 3.154e+10.toInt()),
      ),
    );
    if (newDate != null) {
      time = await showDialog<TimeOfDay>(
        context: context,
        builder: (BuildContext context) => TimePickerDialog(
          initialTime: TimeOfDay.now(),
        ),
      );
    }
    if (time != null && newDate != null) {
      date = DateTime(newDate.year, newDate.month, newDate.day, time.hour, time.minute);
    }
    setState(() {});
  }
}
