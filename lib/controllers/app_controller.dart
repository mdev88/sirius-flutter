import 'package:flutter/material.dart';

class AppController extends ChangeNotifier {
  ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: Colors.pink, brightness: Brightness.dark);

  void changeToLightScheme() {
    scheme = ColorScheme.fromSeed(
        seedColor: Colors.pink, brightness: Brightness.light);
    notifyListeners();
  }

  void changeToDarkScheme() {
    scheme = ColorScheme.fromSeed(
        seedColor: Colors.pink, brightness: Brightness.dark);
    notifyListeners();
  }
}
