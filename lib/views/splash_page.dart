import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:sirius_flutter/main.dart';
import 'package:sirius_flutter/views/home_page.dart';
import 'package:watch_it/watch_it.dart';

import '../controllers/app_controller.dart';
import '../controllers/splash_controller.dart';
import '../services/odoo_service.dart';
import 'login_page.dart';

class SplashPage extends StatelessWidget with WatchItMixin {
  SplashPage({super.key});

  /*
  Reference to the App's controller (for switching color scheme)
   */
  final appCtl = di.get<AppController>();

  /*
  Reference to this page's controller
   */
  final homeCtl = di.get<SplashController>();

  /*
  Reference to Odoo's controller
   */
  final odooSrv = di.get<OdooService>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      checkSession(navigatorKey.currentContext!);
    });

    return Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }

  void checkSession(BuildContext context) async {
    if (odooSrv.orpc.runtimeType != OdooClient) {
      log('OdooClient is not ready');
    }

    if (odooSrv.orpc.runtimeType != OdooClient ||
        odooSrv.orpc!.sessionId?.id == '' ||
        odooSrv.orpc!.sessionId?.id == null) {
      // Go to login
      await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      // Go to home
      await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}
