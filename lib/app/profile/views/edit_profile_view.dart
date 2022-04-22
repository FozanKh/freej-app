import 'package:flutter/material.dart';

import '../../../core/exports/core.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RoundedTextFormField(
              borderColor: kPrimaryColor,
            ),
            RoundedTextFormField(
              borderColor: kPrimaryColor,
            ),
            RoundedTextFormField(
              borderColor: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
