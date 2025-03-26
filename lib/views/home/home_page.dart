import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sirius_flutter/main.dart';
import 'package:sirius_flutter/views/form/FormPage.dart';
import 'package:watch_it/watch_it.dart';

import '../../controllers/home_controller.dart';
import '../../misc/utils.dart';
import '../login/login_page.dart';

class HomePage extends WatchingStatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*
  Reference to this page's controller
   */
  final controller = di.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Sirius demo'),
      ),
      body: watchPropertyValue((HomeController hc) {
        return ListView.builder(
          itemCount: hc.forms.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('View name: ${hc.forms[index].name}'),
                subtitle: Text('Type: ${hc.forms[index].type}'),
                onTap: () {
                  log('Tapped on ${hc.forms[index].name}');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => FormPage(form: hc.forms[index])));
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'logout',
            tooltip: 'Logout',
            onPressed: () async {
              final res = await controller.logout();
              // Go to login
              await Navigator.pushReplacement(navigatorKey.currentContext!,
                  MaterialPageRoute(builder: (context) => LoginPage()));
              log(res.toString());
            },
            child: const Text('Logout'),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
              heroTag: 'getConfigJson',
              onPressed: () async {

                Utils.showProgressDialog(context);

                try {
                  await controller.getConfigJson();
                } catch (e) {
                  log('Error: $e');
                } finally {
                  Utils.closeProgressDialog(context);
                }


              },child: Icon(Icons.sync),),
        ],
      ),
    );
  }
}
