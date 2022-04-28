import 'package:flutter/material.dart';
import 'package:freej/core/exports/core.dart';

class AddReviewView extends StatefulWidget {
  final Function callback;
  const AddReviewView({Key? key, required this.callback}) : super(key: key);

  @override
  State<AddReviewView> createState() => _AddReviewViewState();
}

class _AddReviewViewState extends State<AddReviewView> {
  int rating = 0;
  String? comment;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (index) => Bounce(
              onTap: () => setState(() => rating = index + 1),
              child: Icon(
                (index + 1) <= rating ? Icons.star_rounded : Icons.star_outline_rounded,
                size: 50,
                color: (index + 1) <= rating ? kPrimaryColor : kGrey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        RoundedTextFormField(
          title: "comment".translate,
          maxLines: 3,
          onChanged: (value) => comment = value,
        ),
        RoundedButton(
          title: "submit".translate,
          onTap: () async {
            if ((comment?.length ?? 0) < 4) {
              AlertDialogBox.showAlert(context, message: 'please_enter_proper_comment'.translate);
            } else if (await widget.callback(rating, comment)) {
              Nav.popPage(context);
            }
          },
        )
      ],
    );
  }
}
