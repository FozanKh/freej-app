import 'package:flutter/material.dart';
import 'package:freej/core/components/expandable_picker.dart';
import 'package:freej/core/exports/core.dart';

import '../../campus/models/building.dart';
import '../../campus/models/campus.dart';
import '../controllers/registration_controller.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  late final RegistrationController controller;

  @override
  void initState() {
    controller = RegistrationController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('registration'.translate),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Insets.m) + const EdgeInsets.only(bottom: 200),
        child: Form(
          key: controller.formKey,
          onChanged: () => setState(() {}),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Titled(
                title: 'choose_your_campus'.translate,
                child: FutureBuilder<List<Campus>>(
                  future: controller.getAllCampuses(),
                  builder: (context, campuses) {
                    if (!campuses.hasData) return const Center(child: CircularProgressIndicator());
                    return Wrap(
                      children: List.generate(
                        campuses.data!.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CampusCard(
                            onTap: () => controller.selectCampus(campuses.data![index]).then((_) => setState(() {})),
                            campus: campuses.data![index],
                            isSelected: controller.selectedCampus == campuses.data![index],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              RoundedTextFormField(
                title: 'email'.translate,
                initialValue: controller.email,
                hint: 'university_email'.translate,
                clearButton: false,
                validator: controller.emailValidator,
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
              if (controller.selectedCampus != null)
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

class CampusCard extends StatelessWidget {
  const CampusCard({
    Key? key,
    required this.campus,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  final Campus campus;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        width: 150,
        padding: const EdgeInsets.all(Insets.m),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? kPrimaryColor : Colors.grey,
            width: 2,
          ),
          borderRadius: Borders.mBorderRadius,
        ),
        child: CachedImage(url: campus.image),
      ),
    );
  }
}
