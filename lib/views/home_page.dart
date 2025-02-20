import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sirius_flutter/main.dart';
import 'package:watch_it/watch_it.dart';

import '../services/odoo_service.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  /*
  Reference to Odoo's controller
   */
  final odooSrv = di.get<OdooService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Sirius demo'),
      ),
      body: Center(
        child: Text(
          '${odooSrv.orpc!.sessionId?.toString()}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Logout',
        onPressed: () async {
          final res = await odooSrv.logout();
          // Go to login
          await Navigator.pushReplacement(navigatorKey.currentContext!,
              MaterialPageRoute(builder: (context) => LoginPage()));
          log(res.toString());
        },
        child: const Text('Logout'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
