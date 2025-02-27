import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sirius_flutter/controllers/login_controller.dart';
import 'package:sirius_flutter/main.dart';
import 'package:watch_it/watch_it.dart';

import 'home_page.dart';

class LoginPage extends WatchingStatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /*
  Reference to this page's controller
   */
  final loginCtl = di.get<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: loginCtl.formKey,
              child: Column(
                children: [
                  const Text('Login', style: TextStyle(fontSize: 22)),
                  const SizedBox(height: 16),
                  watchPropertyValue((LoginController lc) {
                    return TextFormField(
                      controller: loginCtl.usernameCtl,
                      style: const TextStyle(fontSize: 20),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: loginCtl.onUsernameChanged,
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.person),
                        labelText: 'Username or email',
                        errorText: lc.usernameErrorText,
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  watchPropertyValue((LoginController lc) {
                    return TextFormField(
                      controller: loginCtl.passwordCtl,
                      style: const TextStyle(fontSize: 20),
                      onChanged: loginCtl.onPasswordChanged,
                      textInputAction: TextInputAction.next,
                      autofocus: false,
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock_outline),
                        labelText: 'Password',
                        errorText: lc.passwordErrorText,
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: loginCtl.serverCtl,
                    style: const TextStyle(fontSize: 20),
                    onChanged: loginCtl.onServerChanged,
                    textInputAction: TextInputAction.next,
                    autofocus: false,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.computer),
                      labelText: 'Server URL',
                      hintText: 'http://...',
                      errorText: loginCtl.serverErrorText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: loginCtl.portCtl,
                    style: const TextStyle(fontSize: 20),
                    onChanged: loginCtl.onPortChanged,
                    textInputAction: TextInputAction.next,
                    autofocus: false,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.import_export),
                      labelText: 'Port',
                      hintText: '8069',
                      errorText: loginCtl.portErrorText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: loginCtl.dbCtl,
                    style: const TextStyle(fontSize: 20),
                    onChanged: loginCtl.onDbChanged,
                    textInputAction: TextInputAction.done,
                    autofocus: false,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.storage),
                      labelText: 'Database name',
                      errorText: loginCtl.dbErrorText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child:
                        watchPropertyValue((LoginController lc) => lc.loading)
                            ? GestureDetector(
                                onLongPress: () async {
                                  loginCtl.formKey.currentState?.reset();
                                  // await loginCtl.abortLogin();
                                },
                                child: SpinKitRotatingCircle(
                                    color: Theme.of(context).primaryColor,
                                    size: 40.0))
                            : ElevatedButton.icon(
                                onPressed: () async {
                                  try {
                                    final res = await loginCtl.login();
                                    if (res) {
                                      // Go to login
                                      await Navigator.pushReplacement(
                                          navigatorKey.currentContext!,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    }
                                  } catch (e) {
                                    log(e.toString());
                                  }
                                },
                                icon: const Icon(Icons.login),
                                label: Text(
                                  'Login',
                                  style: const TextStyle(fontSize: 18),
                                )),
                  ),
                  const SizedBox(height: 16),
                  watchPropertyValue(
                          (LoginController lc) => lc.errorMessage.isNotEmpty)
                      ? Text(loginCtl.errorMessage,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error))
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
