import 'package:flutter/material.dart';
import 'package:freej/app/profile/controllers/edit_profile_controller.dart';
import 'package:freej/core/constants/phosphor_icons.dart';
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
      name: user.account?.name ?? '',
      // lastName: user.account?.lastName ?? '',
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
        title: Text("complete_your_profile".translate, style: TextStyles.t1.withColor(kPrimaryColor)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Insets.l),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Bounce(
                onTap: () => controller.updateAvatar().then((_) => setState(() {})),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: kWhite,
                          shape: BoxShape.circle,
                        ),
                        foregroundDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: kPrimaryColor, width: 2),
                        ),
                        child: CachedImage(
                          url: controller.photoUrl ?? user.photo,
                          shape: BoxShape.circle,
                          fit: BoxFit.cover,
                          size: Size(MediaQuery.of(context).size.width / 3, MediaQuery.of(context).size.width / 3),
                          errorWidget: const Icon(PhosphorIcons.user, size: 100, color: kPrimaryColor),
                        ),
                      ),
                      Container(
                        child: const Icon(
                          PhosphorIcons.pencil_simple_bold,
                          color: kPrimaryColor,
                        ),
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: const BoxDecoration(
                          color: kWhite,
                          shape: BoxShape.circle,
                          boxShadow: Styles.boxShadow,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RoundedTextFormField(
                title: 'name'.translate,
                borderColor: kPrimaryColor,
                validator: controller.nameValidator,
                hint: user.account?.name ?? 'first_name'.translate,
              ),
              const SizedBox(height: 20),
              // RoundedTextFormField(
              //   title: 'last_name'.translate,
              //   borderColor: kPrimaryColor,
              //   validator: controller.lastNameValidator,
              //   hint: user.account?.lastName ?? 'last_name'.translate,
              // ),
              // const SizedBox(height: 20),
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
    );
  }
}
