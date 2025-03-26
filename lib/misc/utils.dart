import 'package:flutter/material.dart';

class Utils {
  static showProgressDialog(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    width: 150,
                    height: 150,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.tertiary,
                    ))),
              ],
            ),
          );
        });
  }

  static closeProgressDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
