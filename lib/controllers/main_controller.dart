import 'package:flutter/foundation.dart';

import '../models/user.dart';

class MainController extends ChangeNotifier {
  /*
  Counter
   */
  int counter = 0;

  void incrementCounter() {
    counter++;
    notifyListeners();

    if (counter == 5) {
      changeTitle();
    }
    if (counter == 10) {
      user.name = 'Javier';
    }
    if (counter == 15) {
      finished = true;
    }
  }

  /*
  Title
   */
  String title = 'Sirius';

  void changeTitle() {
    title = 'Sirius DEMO';
    notifyListeners();
  }

  /*
  User
   */
  User user = User();

  /*
  Finished
   */
  bool finished = false;
}
