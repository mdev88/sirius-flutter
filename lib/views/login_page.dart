import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/odoo_service.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  /*
  Reference to Odoo's controller
   */
  final odooSrv = GetIt.I.get<OdooService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          children: const [
            Text('Login page'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Login',
        onPressed: () async {
          final res = await odooSrv.login();
          // Go to login
          await Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
          log(res.toString());
        },
        child: const Text('Login'),
      ),
    );
  }
}
