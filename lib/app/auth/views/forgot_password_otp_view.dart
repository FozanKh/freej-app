import 'package:flutter/material.dart';

import '../../../core/exports/core.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordOtpView extends StatefulWidget {
  final ForgotPasswordController controller;
  const ForgotPasswordOtpView({Key? key, required this.controller}) : super(key: key);

  @override
  _OtpSubmissionViewState createState() => _OtpSubmissionViewState();
}

class _OtpSubmissionViewState extends State<ForgotPasswordOtpView> {
  String otp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP'.translate),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Insets.m),
        child: Column(
          children: [
            RoundedTextFormField(
              hint: 'XXX XXX',
              center: true,
              clearButton: false,
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() => otp = value),
            ),
            const SizedBox(height: 20),
            RoundedButton(
              enabled: otp.length == 4,
              title: 'next'.translate,
              onTap: () => widget.controller.conformOtp(otp),
            ),
          ],
        ),
      ),
    );
  }
}
