import 'package:flutter/material.dart';
import 'package:freej/app/profile/controllers/edit_profile_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/exports/core.dart';
import '../../auth/models/user.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late EditProfileController controller;
  late User user;
  @override
  void initState() {
    user = context.read<User>();
    controller = EditProfileController(
      context,
      firstName: user.account?.firstName ?? '',
      lastName: user.account?.lastName ?? '',
      mobile: user.account?.mobileNumber ?? '',
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    user = context.watch<User>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Text("complete_your_profile".translate, style: TextStyles.t1.withColor(kPrimaryColor)),
          const SizedBox(height: 100),
          SingleChildScrollView(
            padding: const EdgeInsets.all(Insets.l),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  RoundedTextFormField(
                    title: 'first_name'.translate,
                    borderColor: kPrimaryColor,
                    validator: controller.firstNameValidator,
                    hint: user.account?.firstName ?? 'first_name'.translate,
                  ),
                  const SizedBox(height: 20),
                  RoundedTextFormField(
                    title: 'last_name'.translate,
                    borderColor: kPrimaryColor,
                    validator: controller.lastNameValidator,
                    hint: user.account?.lastName ?? 'last_name'.translate,
                  ),
                  const SizedBox(height: 20),
                  RoundedTextFormField(
                    title: 'phone_number'.translate,
                    borderColor: kPrimaryColor,
                    validator: controller.mobileValidator,
                    hint: user.account?.mobileNumber ?? '05XXXXXXXX',
                  ),
                  const SizedBox(height: 30),
                  RoundedButton(
                    title: 'save'.translate,
                    onTap: controller.saveChanges,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
