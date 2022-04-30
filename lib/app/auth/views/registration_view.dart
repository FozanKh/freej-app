import 'package:flutter/material.dart';
import 'package:freej/core/components/expandable_picker.dart';
import 'package:freej/core/exports/core.dart';

import '../../campus/models/building.dart';
import '../controllers/registration_controller.dart';

class RegistrationView extends StatefulWidget {
  final String email;

  const RegistrationView({Key? key, required this.email}) : super(key: key);

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  late final RegistrationController controller;

  @override
  void initState() {
    controller = RegistrationController(context, widget.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('registration'.translate),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Insets.m),
        child: Form(
          key: controller.formKey,
          onChanged: () => setState(() {}),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              RoundedTextFormField(
                title: 'email'.translate,
                initialValue: controller.email,
                enabled: false,
                clearButton: false,
              ),
              const SizedBox(height: 20),
              RoundedTextFormField(
                title: 'name'.translate,
                hint: 'your_name'.translate,
                validator: controller.nameValidator,
              ),
              const SizedBox(height: 20),
              RoundedTextFormField(
                title: 'phone_number'.translate,
                hint: '05XXXXXXXX'.translate,
                validator: controller.mobileValidator,
              ),
              const SizedBox(height: 20),
              RoundedTextFormField(
                title: 'password'.translate,
                hint: '**********',
                validator: controller.passwordValidator,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<Building>>(
                future: controller.availableBuildings,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const CircularProgressIndicator();
                  return Column(
                    children: [
                      Titled(
                        title: 'building'.translate,
                        child: ExpandablePicker(
                          title: "building_number".translate,
                          options: snapshot.data!.map((e) => e.name).toList(),
                          value: controller.selectedBuilding?.name,
                          callback: (index) => setState(() => controller.selectedBuilding = snapshot.data![index]),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (controller.selectedBuilding != null)
                        Titled(
                          title: 'room'.translate,
                          child: ShowUp(
                            child: ExpandablePicker(
                              title: "room_number".translate,
                              options: controller.selectedBuilding!.rooms.map((e) => e.name).toList(),
                              value: controller.selectedRoom?.name,
                              callback: (index) =>
                                  setState(() => controller.selectedRoom = controller.selectedBuilding!.rooms[index]),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              RoundedButton(
                enabled: controller.formKey.currentState?.validate() ?? false,
                title: 'next'.translate,
                onTap: controller.getOtp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
