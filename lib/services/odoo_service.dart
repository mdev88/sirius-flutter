import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch_it/watch_it.dart';

import '../config/odoo_secrets.dart';
import '../models/sirius_form.dart';

typedef SessionChangedCallback = void Function(OdooSession sessionId);

/// Callback for session changed events
SessionChangedCallback storeSesion(SharedPreferences prefs) {
  /// Define func that will be called on every session update.
  /// It receives configured [SharedPreferences] instance.
  void sessionChanged(OdooSession sessionId) {
    if (sessionId.id == '') {
      Logger().i('sessionChanged - sessionId.id == \'\'');
      prefs.remove(cacheSessionKey);
    } else {
      Logger().i('sessionChanged - ${sessionId.toJson()}');
      prefs.setString(cacheSessionKey, json.encode(sessionId.toJson()));
    }
  }

  return sessionChanged;
}

class OdooService extends ChangeNotifier {
  OdooClient? orpc;

  List<SiriusForm> forms = [];

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    final serverURL = prefs.getString('serverURL') ?? '';
    final serverPort = prefs.getInt('serverPort') ?? 0;
    final username = prefs.getString('username') ?? '';
    final password = prefs.getString('password') ?? '';
    final databaseName = prefs.getString('databaseName') ?? '';

    if (serverURL.isEmpty || serverPort == 0) {
      return;
    }

    // Restore session if it was stored in shared prefs
    final sessionString = prefs.getString(cacheSessionKey);
    OdooSession? session = sessionString == null
        ? null
        : OdooSession.fromJson(json.decode(sessionString));
    orpc = OdooClient('$serverURL:$serverPort', sessionId: session);

    // Bind session change listener to store recent session
    final sessionChangedHandler = storeSesion(prefs);
    orpc!.sessionStream.listen(sessionChangedHandler);

    /// Here restored session may already be expired.
    /// We will know it on any RPC call getting [OdooSessionExpiredException] exception.
    if (sessionString == null) {
      Logger().i('Not logged in. Attempting new login.');
      await orpc!.authenticate(databaseName, username, password);
    } else {
      Logger().i('Using existing session. Hope it is not expired');
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

      Logger().i('Session: ${orpc?.sessionId}');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('serverURL', serverURL);
      await prefs.setInt('serverPort', serverPort);
      await prefs.setString('databaseName', databaseName);
      await prefs.setString('username', username);
      await prefs.setString('password', password);

      notifyListeners();
      return true;
    } catch (e) {
      Logger().e('$e');
      notifyListeners();
      return false;
    }
  }

  Future<List<SiriusForm>> getConfigJson() async {
    final prefs = await SharedPreferences.getInstance();

    final serverURL = prefs.getString('serverURL') ?? '';
    final serverHost = Uri.parse(serverURL).host;
    final serverScheme = Uri.parse(serverURL).scheme;
    final serverPort = prefs.getInt('serverPort') ?? 0;
    final token = di<OdooService>().orpc!.sessionId!.id;

    final headersData = {"cookie": "session_id=$token"};

    final url = Uri.http('$serverHost:$serverPort', 'sirius');
    log('*** $url');

    final res = await http.get(url, headers: headersData);

    try {
      json.decode(res.body);
    } on FormatException catch (_) {
      Logger().e('Not a JSON response!\n\n${res.body}');
      throw Exception('Not a JSON response');
    }

    Logger().i('/sirius response:\n${res.body}');

    final jsonRes = json.decode(res.body);

    final List<SiriusForm> forms =
        jsonRes.map<SiriusForm>((form) => SiriusForm.fromJson(form)).toList();

    return forms;
  }

  Future<bool> logout() async {
    try {
      await orpc!.destroySession();
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      notifyListeners();
      Logger().i('Logged out');
      return true;
    } catch (e) {
      Logger().e('$e');
      notifyListeners();
      return false;
    }
  }
}
