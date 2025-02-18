import 'package:flutter/material.dart';
import 'package:sirius_flutter/controllers/app_controller.dart';
import 'package:sirius_flutter/controllers/home_controller.dart';
import 'package:watch_it/watch_it.dart';

import 'services/odoo_service.dart';
import 'views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  getItSetup();

  await GetIt.I.get<OdooService>().init();

  runApp(const MyApp());
}

// Get_it setup.
void getItSetup() {
  GetIt.I.registerSingleton<AppController>(AppController());
  GetIt.I.registerSingleton<OdooService>(OdooService());
  GetIt.I.registerSingleton<HomeController>(HomeController());
}

class MyApp extends StatelessWidget with WatchItMixin {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sirius Demo',
      theme: ThemeData(
        colorScheme: watchPropertyValue((AppController ac) => ac.scheme),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
