import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freej/app/auth/services/auth_services.dart';
import 'package:freej/app/auth/views/forgot_password_otp_view.dart';
import 'package:freej/app/auth/views/reset_password_view.dart';

import '../../../core/exports/core.dart';

class ForgotPasswordController {
  final BuildContext context;
  late BuildContext restPasswordContext;
  String password = '';
  String secondPassword = '';
  String email = '';
  String name = '';
  String? resetPasswordToken;
  late ProgressDialog pr;

  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  ForgotPasswordController(this.context) {
    pr = ProgressDialog(context);
  }

  // String? mobileValidator(String value) {
  //   mobile = value.validateNumbers;
  //   return !validateMobile(mobile) ? translateText('invalid_error', arguments: ['mobile_number']) : null;
  // }

  String? emailValidator(String value) {
    email = value.validateNumbers;
    return !validateEmail(email) ? translateText('invalid_error', arguments: ['email']) : null;
  }

  String? passwordValidator(String value) {
    password = value;
    return !validatePassword(password) ? translateText('invalid_error', arguments: ['password']) : null;
  }

  String? secondPasswordValidator(String value) {
    secondPassword = value;
    return !validatePassword(password) || secondPassword != password ? 'passwords_dont_match'.translate : null;
  }

  Future<void> getOtp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    await pr.show();
    try {
      await AuthServices.getForgotPasswordOtp(email: email);
      await pr.hide();

      if (await Nav.openPage(context: context, page: ForgotPasswordOtpView(controller: this)) ?? false) {
        Nav.popPage(context, args: true);
      }
    } catch (e) {
      await pr.hide();
      AlertDialogBox.showAlert(context, message: e.toString().translate);
      log(e.toString());
    }
  }

  Future<void> conformOtp(String otp) async {
    await pr.show();

    try {
      resetPasswordToken = await AuthServices.conformForgotPasswordOtp(
        otp: otp,
        email: email,
      );
      await pr.hide();
      await openResetPasswordView();
      Nav.popPage(context, args: true);
      log('Registration done successfully', name: "conformRegistration/RegistrationController");
    } catch (e) {
      AlertDialogBox.showAlert(context, message: e.toString().translate);
      log(e.toString());
    }
  }

  Future<void> openResetPasswordView() async {
    await Nav.openPage(context: context, page: ResetPasswordView(controller: this));
  }

  Future<void> resetPassword() async {
    await pr.show();
    try {
      if (resetPasswordToken != null) {
        await AuthServices.changePassword(email: email, password: password, token: resetPasswordToken!);
      }
      await pr.hide();
      await AlertDialogBox.showAlert(context, message: 'password_changed_successfully'.translate);
      Nav.popPage(context);
      log('Registration done successfully', name: "conformRegistration/RegistrationController");
    } catch (e) {
      await AlertDialogBox.showAlert(context, message: e.toString().translate);
      log(e.toString());
    }
  }
}
