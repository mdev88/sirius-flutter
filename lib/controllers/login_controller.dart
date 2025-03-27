import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:watch_it/watch_it.dart';

import '../services/odoo_service.dart';

class LoginController extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController usernameCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  TextEditingController serverCtl = TextEditingController();
  TextEditingController portCtl = TextEditingController();
  TextEditingController dbCtl = TextEditingController();

  String username = '';
  String password = '';
  String server = '';
  String port = '';
  String db = '';

  String? usernameErrorText;
  String? passwordErrorText;
  String? serverErrorText;
  String? portErrorText;
  String? dbErrorText;

  String errorMessage = '';

  bool loading = false;

  bool get hasErrors {
    return usernameErrorText != null ||
        passwordErrorText != null ||
        serverErrorText != null ||
        portErrorText != null ||
        dbErrorText != null;
  }

  void onUsernameChanged(String value) {
    usernameErrorText = null;
    username = usernameCtl.text;
    notifyListeners();
  }

  void onPasswordChanged(String value) {
    passwordErrorText = null;
    password = passwordCtl.text;
    notifyListeners();
  }

  void onServerChanged(String value) {
    serverErrorText = null;
    server = serverCtl.text;
    notifyListeners();
  }

  void onPortChanged(String value) {
    portErrorText = null;
    port = portCtl.text;
    notifyListeners();
  }

  void onDbChanged(String value) {
    dbErrorText = null;
    db = dbCtl.text;
    notifyListeners();
  }

  void validateForm() {
    if (usernameCtl.text.isEmpty) {
      usernameErrorText = 'Username is required';
    }
    if (passwordCtl.text.isEmpty) {
      passwordErrorText = 'Password is required';
    }
    if (serverCtl.text.isEmpty) {
      serverErrorText = 'Server is required';
    }
    if (portCtl.text.isEmpty) {
      portErrorText = 'Port is required';
    }
    if (dbCtl.text.isEmpty) {
      dbErrorText = 'Database is required';
    }
    notifyListeners();
  }

  void resetForm() {
    formKey.currentState!.reset();
  }

  Future<bool> login() async {
    errorMessage = '';
    notifyListeners();
    validateForm();
    if (hasErrors) {
      return false;
    }
    loading = true;
    notifyListeners();
    // Call the login service
    try {
      final res = await di.get<OdooService>().login(
          serverURL: server,
          serverPort: int.parse(port),
          databaseName: db,
          username: username,
          password: password);
      loading = false;
      notifyListeners();
      if (res == false) {
        errorMessage = 'Login failed';
        notifyListeners();
        return false;
      } else {
        resetForm();
        return true;
      }
    } catch (e) {
      Logger().e(e.toString());
      loading = false;
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  void abortLogin() {
    loading = false;
    notifyListeners();
  }
}
