import 'package:flutter/material.dart';
import 'package:sirius_flutter/controllers/home_controller.dart';
import 'package:watch_it/watch_it.dart';

import 'views/home_page.dart';

// Global Get_it instance
final getIt = GetIt.instance;

// Get_it setup.
void getItSetup() {
  getIt.registerSingleton<HomeController>(HomeController());
}

void main() {
  getItSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sirius Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
