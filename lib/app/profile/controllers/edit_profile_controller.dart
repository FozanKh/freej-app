import 'package:flutter/material.dart';
import 'package:freej/app/auth/models/user.dart';
import 'package:freej/app/campus/models/room.dart';
import 'package:freej/app/campus/repositories/building_repository.dart';
import 'package:freej/app/profile/services/profile_services.dart';
import 'package:provider/provider.dart';

import '../../../core/exports/core.dart';
import '../../campus/models/building.dart';

class EditProfileController {
  final BuildContext context;
  late ProgressDialog pr;
  String firstName = '';
  String lastName = '';
  String mobile = '';
  Room? selectedRoom;
  Building? selectedBuilding;
  Future<List<Building>>? availableBuildings = BuildingRepository.instance.getAllBuildings();

  EditProfileController(this.context, {this.firstName = '', this.lastName = '', this.mobile = ''}) {
    pr = ProgressDialog(context);
  }
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? firstNameValidator(String value) {
    if (value.isNotEmpty) firstName = value;
    return !validateName(firstName) ? translateText('invalid_error', arguments: ['first_name']) : null;
  }

  String? lastNameValidator(String value) {
    if (value.isNotEmpty) lastName = value;
    return !validateName(lastName) ? translateText('invalid_error', arguments: ['last_name']) : null;
  }

  String? mobileValidator(String value) {
    if (value.isNotEmpty) mobile = value;
    return !validateMobile(mobile) ? translateText('invalid_error', arguments: ['phone_number']) : null;
  }

  Future<void> saveChanges() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    pr.show();

    try {
      User newUser = await ProfileServices.updateProfile(firstName, lastName, mobile);
      context.read<User>().updateFromUser(newUser);
      pr.hide();
      Nav.popPage(context);
    } catch (e) {
      pr.hide();
      AlertDialogBox.showAlert(context, message: e.toString());
    }
    return;
  }
}
