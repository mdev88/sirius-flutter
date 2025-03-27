import 'dart:developer';

import 'package:flutter/material.dart';

class U {
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

  static Future<void> showMessageDialog(
      BuildContext context, String message) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(40.0),
            child: Material(
              color: Colors.transparent,
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                direction: Axis.vertical,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 20.0, 20.0, 8.0),
                            child: Text(
                              message,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('Close'))
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  static closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void callAsyncMethod({
    required BuildContext context,
    required Future<void> Function() method,
    bool showProgressDialog = true,
    bool showErrorsInDialog = true,
  }) async {
    if (showProgressDialog) U.showProgressDialog(context);

    try {
      await method();
      U.closeDialog(context);
    } catch (e) {
      if (context.mounted) {
        U.closeDialog(context);
        if (showErrorsInDialog) {
          await showMessageDialog(context, e.toString());
        }
      }
    }
  }
}
