import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirius_flutter/services/odoo_service.dart';
import 'package:watch_it/watch_it.dart';

class ConfigService extends ChangeNotifier {
  // Future<void> getConfigJson() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final serverUrl = prefs.getString('serverUrl') ?? '';
  //   final serverPort = prefs.getInt('serverPort') ?? 0;
  //   final databaseName = prefs.getString('databaseName') ?? '';
  //   final serverFullUrl = '$serverUrl:$serverPort/sirius';
  //
  //   final token = di<OdooService>().orpc!.sessionId!.id;
  //
  //   log('Stored token: $token');
  //
  //   final headersData = {
  //     "Content-type": "application/json",
  //     "Authorization": token
  //   };
  //
  //   final url = Uri.https('$serverUrl:$serverPort', '/sirius');
  //
  //   final res = await http.get(url, headers: headersData);
  //
  //   log('/sirius response: $res');
  // }
}
