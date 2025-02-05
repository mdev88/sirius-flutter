import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import '../controllers/app_controller.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget with WatchItMixin {
  HomePage({super.key});

  /*
  Instance of this page's controller
   */
  final homeCtl = GetIt.I.get<HomeController>();

  /*
  Instance of the App's controller (for switching color scheme)
   */
  final appCtl = GetIt.I.get<AppController>();

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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            tooltip: 'Increment',
            onPressed: homeCtl.pushButtonAction,
            child: const Icon(Icons.plus_one),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            tooltip: 'Increment',
            onPressed: appCtl.changeToDarkScheme,
            child: const Icon(Icons.palette_outlined),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            tooltip: 'Increment',
            onPressed: appCtl.changeToLightScheme,
            child: const Icon(Icons.palette_rounded),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
