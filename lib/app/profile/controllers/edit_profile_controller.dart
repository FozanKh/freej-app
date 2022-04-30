import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freej/app/auth/models/user.dart';
import 'package:freej/app/campus/models/room.dart';
import 'package:freej/app/campus/repositories/building_repository.dart';
import 'package:freej/app/profile/services/profile_services.dart';
import 'package:provider/provider.dart';

import '../../../core/exports/core.dart';
import '../../../core/services/firebase/storage_services.dart';
import '../../campus/models/building.dart';

class EditProfileController {
  final BuildContext context;
  late ProgressDialog pr;
  String name = '';
  String lastName = '';
  String mobile = '';
  Room? selectedRoom;
  Building? selectedBuilding;
  String? photoUrl;
  Future<List<Building>>? availableBuildings = BuildingRepository.instance.getAllBuildings();

  EditProfileController(this.context, {this.name = '', this.lastName = '', this.mobile = ''}) {
    pr = ProgressDialog(context);
  }
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? nameValidator(String value) {
    if (value.isNotEmpty) name = value;
    return !validateName(name) ? translateText('invalid_error', arguments: ['name']) : null;
  }

  // String? lastNameValidator(String value) {
  //   if (value.isNotEmpty) lastName = value;
  //   return !validateName(lastName) ? translateText('invalid_error', arguments: ['last_name']) : null;
  // }

  String? mobileValidator(String value) {
    if (value.isNotEmpty) mobile = value;
    return !validateMobile(mobile) ? translateText('invalid_error', arguments: ['phone_number']) : null;
  }

  Future<void> updateAvatar() async {
    await pr.show();
    try {
      photoUrl = await StorageServices.uploadAvatar(context.read<User>().id!);
      log("url:$photoUrl");
      context.read<User>();
      await pr.hide();
    } catch (e) {
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: e.toString());
    }
    return;
  }

  Future<void> saveChanges() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    pr.show();
    try {
      User newUser = await ProfileServices.updateProfile(name, lastName, mobile, photoUrl);
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
