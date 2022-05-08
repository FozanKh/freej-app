import 'package:flutter/material.dart';
import 'package:freej/app/auth/controllers/forgot_password_controller.dart';

import '../../../core/exports/core.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final ForgotPasswordController controller;
  @override
  void initState() {
    controller = ForgotPasswordController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(Insets.l),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 50),
                  child: Image.asset(
                    Assets.kFreejLogoAsset,
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                ),
              ),
              Text('forgot_password'.translate, style: TextStyles.t1),
              const SizedBox(height: 20),
              Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: () => setState(() {}),
                child: Column(
                  children: [
                    RoundedTextFormField(
                      title: "email".translate,
                      hint: 'university_email'.translate,
                      validator: controller.emailValidator,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              RoundedButton(
                title: "reset_password".translate,
                onTap: controller.getOtp,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
