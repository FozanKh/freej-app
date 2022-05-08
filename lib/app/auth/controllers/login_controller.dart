import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/exports/core.dart';
import '../../../core/services/firebase/fcm_services.dart';
import '../../../core/services/local/shared_pref.dart';
import '../models/auth_token.dart';
import '../models/user.dart';
import '../services/auth_services.dart';
import '../views/registration_view.dart';

class LoginController {
  final BuildContext context;
  String email;
  String password;
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final ProgressDialog pr;

  LoginController(this.context, {this.email = '', this.password = ''}) {
    pr = ProgressDialog(context);
  }

  String? emailValidator(String value) {
    email = value.validateNumbers;
    return !validateEmail(email) ? translateText('invalid_error', arguments: ['email']) : null;
  }

  String? passwordValidator(String value) {
    password = value;
    return !validatePassword(password) ? translateText('invalid_error', arguments: ['password']) : null;
  }

  Future<void> signIn({bool validate = true}) async {
    if (validate && !formKey.currentState!.validate()) {
      return;
    }

    await pr.show();
    try {
      final newToken = await AuthServices.login(username: email.toString(), password: password);
      context.read<AuthToken>().updateFromToken(newToken, notify: false);
      await SharedPreference.instance.saveToken(newToken, notify: false);
    } catch (e) {
      await pr.hide();
      context.read<AuthToken>().remove();
      AlertDialogBox.showAlert(context, message: e.toString());
      return;
    }

    try {
      final newUser = await AuthServices.getUserProfile();
      context.read<User>().updateFromUser(newUser, notify: false);
      await pr.hide();
    } catch (e) {
      await pr.hide();
      await AuthServices.logout(context);
      AlertDialogBox.showAlert(context, message: e.toString());
    }
    context.read<User>().notifyListeners();
    context.read<AuthToken>().notifyListeners();
    if (context.read<AuthToken>().access?.isActive ?? false) FCM.init();
    return;
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    await Nav.openPage(context: context, page: const RegistrationView()) ?? false;
  }
}
