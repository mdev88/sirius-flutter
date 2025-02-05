import 'package:flutter/material.dart';

class AppController extends ChangeNotifier {
  ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: Colors.teal, brightness: Brightness.light);

  void changeToLightScheme() {
    scheme = ColorScheme.fromSeed(
        seedColor: Colors.teal, brightness: Brightness.light);
    notifyListeners();
  }

  void changeToDarkScheme() {
    scheme = ColorScheme.fromSeed(
        seedColor: Colors.teal, brightness: Brightness.dark);
    notifyListeners();
  }
}
