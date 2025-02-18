import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../controllers/app_controller.dart';
import '../controllers/home_controller.dart';
import '../services/odoo_service.dart';

class HomePage extends StatelessWidget with WatchItMixin {
  HomePage({super.key});

  /*
  Reference to the App's controller (for switching color scheme)
   */
  final appCtl = GetIt.I.get<AppController>();

  /*
  Reference to this page's controller
   */
  final homeCtl = GetIt.I.get<HomeController>();

  /*
  Reference to Odoo's controller
   */
  final odooCtl = GetIt.I.get<OdooService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Sirius demo'),
      ),
      body: Column(
        children: [
          Text('User:'),
          Text(
            '${watchPropertyValue((OdooService os) => os.orpc.sessionId?.userName)}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            tooltip: 'Login',
            onPressed: () async {
              final res = await odooCtl.login();
              log(res.toString());
            },
            child: const Icon(Icons.login),
          ),
          SizedBox(
            height: 16,
          ),
          FloatingActionButton(
            tooltip: 'Logout',
            onPressed: () async {
              final res = await odooCtl.logout();
              log(res.toString());
            },
            child: const Icon(Icons.logout),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
