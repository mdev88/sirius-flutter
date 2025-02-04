import 'dart:developer';

import 'package:flutter/foundation.dart';

class MainController extends ChangeNotifier {
  int counter = 0;

  void incrementCounter() {
    counter++;
    notifyListeners();
    log('Counter value: $counter');
    if (counter == 5) {
      changeName();
    }
    if (counter == 10) {
      user.name = 'Javier';
    }
  }

  String name = 'Sirius';

  void changeName() {
    name = 'Martín';
    notifyListeners();
  }

  User user = User();
}

class User {
  String? name;

  User({this.name});
}
