import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch_it/watch_it.dart';
import 'package:http/http.dart' as http;

import '../config/odoo_secrets.dart';

typedef SessionChangedCallback = void Function(OdooSession sessionId);

/// Callback for session changed events
SessionChangedCallback storeSesion(SharedPreferences prefs) {
  /// Define func that will be called on every session update.
  /// It receives configured [SharedPreferences] instance.
  void sessionChanged(OdooSession sessionId) {
    if (sessionId.id == '') {
      log('sessionChanged - sessionId.id == \'\'');
      prefs.remove(cacheSessionKey);
    } else {
      log('sessionChanged - ${sessionId.toJson()}');
      prefs.setString(cacheSessionKey, json.encode(sessionId.toJson()));
    }
  }

  return sessionChanged;
}

class OdooService extends ChangeNotifier {
  OdooClient? orpc;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    String serverURL = prefs.getString('serverURL') ?? '';
    int serverPort = prefs.getInt('serverPort') ?? 0;

    if (serverURL.isEmpty || serverPort == 0) {
      return;
    }

    // Restore session if it was stored in shared prefs
    final sessionString = prefs.getString(cacheSessionKey);
    OdooSession? session = sessionString == null
        ? null
        : OdooSession.fromJson(json.decode(sessionString));
    orpc = OdooClient('$serverURL:$serverPort', session);

    // Bind session change listener to store recent session
    final sessionChangedHandler = storeSesion(prefs);
    orpc!.sessionStream.listen(sessionChangedHandler);

    /// Here restored session may already be expired.
    /// We will know it on any RPC call getting [OdooSessionExpiredException] exception.
    if (sessionString == null) {
      // log('Logging with credentials');
      // await orpc.authenticate(databaseName, username, password);
      log('Not logged in.');
    } else {
      log('Using existing session. Hope it is not expired');
    }
  }

  Future<bool> login(
      {required String serverURL,
      required int serverPort,
      required String databaseName,
      required String username,
      required String password}) async {
    orpc = OdooClient('$serverURL:$serverPort');

    try {
      await orpc!.authenticate(databaseName, username, password);

      log('Session: ${orpc?.sessionId}');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('serverURL', serverURL);
      await prefs.setInt('serverPort', serverPort);
      await prefs.setString('databaseName', databaseName);
      await prefs.setString('username', username);
      await prefs.setString('password', password);

      notifyListeners();
      return true;
    } catch (e) {
      log('$e');
      notifyListeners();
      return false;
    }
  }

  Future<void> getConfigJson() async {
    // final prefs = await SharedPreferences.getInstance();

    final token = di<OdooService>().orpc!.sessionId!.id;

    log('Stored token: $token');

    final headersData = {"cookie": "session_id=$token"};

    final url = Uri.http('martes.faster.es:5069', 'sirius');

    final res = await http.get(url, headers: headersData);

    log('/sirius response: ${res.body}');
  }

  Future<bool> logout() async {
    try {
      await orpc!.destroySession();
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      notifyListeners();
      return true;
    } catch (e) {
      log('$e');
      notifyListeners();
      return false;
    }
  }
}
