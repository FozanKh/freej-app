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
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RegistrationController(this.context, this.email);

  String? passwordValidator(String value) {
    password = value;
    return !validatePassword(password) ? translateText('invalid_error', arguments: ['password']) : null;
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
      await AuthServices.getOtp(
        email: email,
        password: password,
        room: selectedRoom!.id,
      );
      if (await Nav.openPage(context: context, page: OtpSubmissionView(controller: this)) ?? false) {
        Nav.popPage(context, args: true);
      }
    } catch (e) {
      AlertDialogBox.showAlert(context, message: e.toString());
      log(e.toString());
    }
  }

  Future<void> conformRegistration(String otp) async {
    try {
      await AuthServices.conformRegistration(
        otp: otp,
        email: email,
        password: password,
        room: selectedRoom!.id,
      );
      await signIn();
      log('Registration done successfully', name: "conformRegistration/RegistrationController");
    } catch (e) {
      AlertDialogBox.showAlert(context, message: e.toString());
      log(e.toString());
    }
  }

  Future<void> signIn() async {
    await LoginController(context, email: email, password: password).signIn(validate: false);
  }

  void selectRoom({Room? corporate, String? other}) {
    if (selectedRoom == corporate) {
      selectedRoom = null;
    } else {
      selectedRoom = corporate;
    }
  }
}
