import 'package:flutter/material.dart';
import 'package:sirius_flutter/controllers/app_controller.dart';
import 'package:sirius_flutter/controllers/splash_controller.dart';
import 'package:watch_it/watch_it.dart';

import 'controllers/login_controller.dart';
import 'services/odoo_service.dart';
import 'views/splash_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  getItSetup();

  await di.get<OdooService>().init();

  runApp(const MyApp());
}

// Get_it setup.
void getItSetup() {
  di.registerSingleton<AppController>(AppController());
  di.registerSingleton<OdooService>(OdooService());
  di.registerSingleton<SplashController>(SplashController());
  di.registerSingleton<LoginController>(LoginController());
}

class MyApp extends StatelessWidget with WatchItMixin {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Sirius Demo',
      theme: ThemeData(
        colorScheme: watchPropertyValue((AppController ac) => ac.scheme),
        useMaterial3: true,
      ),
      home: SplashPage(),
    );
  }
}
