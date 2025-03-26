import 'package:flutter/cupertino.dart';
import 'package:sirius_flutter/models/sirius_form.dart';
import 'package:watch_it/watch_it.dart';

import '../services/odoo_service.dart';

class HomeController extends ChangeNotifier {
  /*
  Reference to Odoo's controller
   */
  final odooSrv = di.get<OdooService>();

  List<SiriusForm> forms = [];

  getSessionString() {
    return odooSrv.orpc!.sessionId?.toString();
  }

  Future<void> getConfigJson() async {
    try {
      forms = await odooSrv.getConfigJson();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  logout() async {
    await odooSrv.logout();
  }
}
