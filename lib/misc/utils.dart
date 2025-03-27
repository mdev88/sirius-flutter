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

  static showMessageDialog(BuildContext context, String message) async {
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
                    child: Center(child: Text(message))),
              ],
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
    } catch (e) {
      if (showErrorsInDialog && context.mounted) {
        showMessageDialog(context, e.toString());
      }
    } finally {
      if (showProgressDialog) {
        if (context.mounted) {
          U.closeDialog(context);
        }
      }
    }
  }
}
