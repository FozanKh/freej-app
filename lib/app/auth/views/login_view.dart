import 'package:flutter/material.dart';

import '../../../core/exports/core.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  final bool registerMode;
  const LoginView({Key? key, this.registerMode = false}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginController controller;

  @override
  void initState() {
    controller = LoginController(context, registerMode: widget.registerMode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: Insets.l * 1.5, vertical: Insets.l),
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
              Text(controller.registerMode ? 'create_new_account'.translate : 'welcome_to_freej'.translate,
                  style: TextStyles.t1.withColor(kPrimaryColor)),
              const SizedBox(height: 5),
              Text(controller.registerMode ? 'register_subtitle'.translate : 'login_subtitle'.translate,
                  style: TextStyles.body2.withColor(kHintFontsColor)),
              const SizedBox(height: 30),
              Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: () => setState(() {}),
                child: Column(
                  children: [
                    RoundedTextFormField(
                      title: "email".translate,
                      hint: 'name@example.com',
                      keyboardType: TextInputType.number,
                      validator: controller.emailValidator,
                    ),
                    const SizedBox(height: 10),
                    if (!controller.registerMode)
                      RoundedTextFormField(
                        title: "password".translate,
                        hint: '**********',
                        validator: controller.passwordValidator,
                        obscureText: true,
                        onSubmitted: (_) => controller.registerMode ? controller.register() : controller.signIn(),
                      ),
                  ],
                ),
              ),
              RoundedButton(
                title: 'next'.translate,
                onTap: controller.registerMode ? controller.register : controller.signIn,
              ),
              const Spacer(),
              if (MediaQuery.of(context).viewInsets.bottom == 0)
                FadeIn(
                  duration: const Duration(milliseconds: 200),
                  child: RoundedButton(
                    title: controller.registerMode ? 'have_account'.translate : 'dont_have_account'.translate,
                    onTap: () => setState(() => controller.registerMode = !controller.registerMode),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
