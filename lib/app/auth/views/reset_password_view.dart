import 'package:flutter/material.dart';
import 'package:freej/core/exports/core.dart';

import '../controllers/forgot_password_controller.dart';

class ResetPasswordView extends StatefulWidget {
  final ForgotPasswordController controller;
  const ResetPasswordView({Key? key, required this.controller}) : super(key: key);

  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  ForgotPasswordController get controller => widget.controller;

  @override
  void initState() {
    controller.restPasswordContext = context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('reset_password'.translate),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Insets.m),
        child: Form(
          key: controller.resetPasswordFormKey,
          onChanged: () => setState(() {}),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              RoundedTextFormField(
                title: 'new_password'.translate,
                hint: '**********',
                validator: controller.passwordValidator,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              RoundedTextFormField(
                title: 're_enter_your_new_password'.translate,
                hint: '**********',
                validator: controller.secondPasswordValidator,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              RoundedButton(
                enabled: controller.resetPasswordFormKey.currentState?.validate() ?? false,
                title: 'save'.translate,
                onTap: () async {
                  if (controller.resetPasswordFormKey.currentState?.validate() == true) {
                    await controller.resetPassword();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
