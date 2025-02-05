import 'package:flutter/material.dart';
import 'package:sirius_flutter/controllers/main_controller.dart';
import 'package:watch_it/watch_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<MainController>(MainController());
}

void main() {
  setup();
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget with WatchItMixin {
  MyHomePage({super.key});

  final controller = getIt.get<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Sirius demo'),
      ),
      body: Center(
        child: watchPropertyValue((MainController mc) => mc.finished)
            ? Text(
                'This is the end',
                style: Theme.of(context).textTheme.headlineMedium,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    watchPropertyValue((MainController mc) => mc.title),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    'User name: ${watchPropertyValue((MainController mc) => mc.user.name)}',
                  ),
                  Text(
                    '${watchPropertyValue((MainController m) => m.counter)}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.ac_unit_sharp),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
