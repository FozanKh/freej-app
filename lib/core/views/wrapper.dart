import 'package:flutter/material.dart';
import 'package:freej/app/auth/views/login_view.dart';
import 'package:provider/provider.dart';
import 'package:freej/app/scaffold/views/main_scaffold.dart';

import '../../app/auth/models/auth_token.dart';
import '../services/firebase/fcm_services.dart';
import '../services/local/shared_pref.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  late AuthToken authToken;

  @override
  void initState() {
    // PackageService.checkUpdates(context);
    SharedPreference.instance.init(context);
    if (context.read<AuthToken>().access?.isActive ?? false) FCM.init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    authToken = context.watch<AuthToken>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // print("access: ${authToken.access?.token}");
    // print("refresh: ${authToken.refresh?.token}");
    // AuthServices.logout(context);
    if (authToken.isActive) {
      return const MainScaffold();
    } else {
      return const LoginView();
    }
  }
}
