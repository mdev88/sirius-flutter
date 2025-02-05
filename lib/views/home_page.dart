import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget with WatchItMixin {
  HomePage({super.key});

  /*
  Instance of this page's controller
   */
  final controller = GetIt.I.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Sirius demo'),
      ),
      body: watchPropertyValue((HomeController hc) => hc.finished)
          ? Text(
              'This is the end',
              style: Theme.of(context).textTheme.headlineMedium,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contador (int): ${watchPropertyValue((HomeController hc) => hc.counter)}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 10),
                Text(
                  'Observo un String: ${watchPropertyValue((HomeController hc) => hc.title)}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 10),
                Text(
                  'Observo propiedad dentro de un objeto (User.name): ${watchPropertyValue((HomeController hc) => hc.user.name)}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: controller.pushButtonAction,
        child: const Icon(Icons.plus_one),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
