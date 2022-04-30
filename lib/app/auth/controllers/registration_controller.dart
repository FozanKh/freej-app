import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freej/app/auth/controllers/login_controller.dart';
import 'package:freej/app/auth/services/auth_services.dart';
import 'package:freej/app/campus/repositories/building_repository.dart';

import '../../../core/exports/core.dart';
import '../../campus/models/building.dart';
import '../../campus/models/room.dart';
import '../views/otp_submission_view.dart';

class RegistrationController {
  final BuildContext context;
  Room? selectedRoom;
  Building? selectedBuilding;
  Future<List<Building>>? availableBuildings = BuildingRepository.instance.getAllBuildings();
  final String email;
  String password = '';
  String name = '';
  String mobile = '';
  late ProgressDialog pr;
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RegistrationController(this.context, this.email) {
    pr = ProgressDialog(context);
  }

  String? nameValidator(String value) {
    name = value;
    return !validateName(name) ? translateText('invalid_error', arguments: ['name']) : null;
  }

  String? passwordValidator(String value) {
    password = value;
    return !validatePassword(password) ? translateText('invalid_error', arguments: ['password']) : null;
  }

  String? mobileValidator(String value) {
    if (value.isNotEmpty) mobile = value;
    return !validateMobile(mobile) ? translateText('invalid_error', arguments: ['phone_number']) : null;
  }

  Future<void> getOtp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (selectedRoom == null) {
      await AlertDialogBox.showAlert(context, message: translateText('please_choose_your', arguments: ['room']));
      return;
    }

    try {
      await pr.show();
      await AuthServices.getOtp(
        name: name,
        email: email,
        password: password,
        mobile: mobile,
        room: selectedRoom!.id,
      );
      await pr.hide();
      if (await Nav.openPage(context: context, page: OtpSubmissionView(controller: this)) ?? false) {
        Nav.popPage(context, args: true);
      }
    } catch (e) {
      await pr.hide();
      AlertDialogBox.showAlert(context, message: e.toString());
      log(e.toString());
    }
  }

  Future<void> conformRegistration(String otp) async {
    try {
      await pr.show();
      await AuthServices.conformRegistration(
        name: name,
        otp: otp,
        email: email,
        mobile: mobile,
        password: password,
        room: selectedRoom!.id,
      );
      await pr.hide();
      await signIn();
      log('Registration done successfully', name: "conformRegistration/RegistrationController");
      Nav.popPage(context, args: true);
    } catch (e) {
      await pr.hide();
      AlertDialogBox.showAlert(context, message: e.toString());
      log(e.toString());
    }
  }

  Future<void> signIn() async {
    await LoginController(context, email: email, password: password).signIn(validate: false);
  }

  void selectRoom({Room? room, String? other}) {
    if (selectedRoom == room) {
      selectedRoom = null;
    } else {
      selectedRoom = room;
    }
  }
}
