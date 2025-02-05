import 'package:flutter/material.dart';
import 'package:sirius_flutter/controllers/app_controller.dart';
import 'package:sirius_flutter/controllers/home_controller.dart';
import 'package:watch_it/watch_it.dart';

import 'views/home_page.dart';

// Get_it setup.
void getItSetup() {
  GetIt.I.registerSingleton<AppController>(AppController());
  GetIt.I.registerSingleton<HomeController>(HomeController());
}

void main() {
  getItSetup();
  runApp(const MyApp());
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
