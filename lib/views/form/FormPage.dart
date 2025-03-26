import 'package:flutter/material.dart';
import 'package:sirius_flutter/models/sirius_form.dart';
import 'package:watch_it/watch_it.dart';

class FormPage extends WatchingStatefulWidget {
  const FormPage({super.key, required this.form});

  final SiriusForm form;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.form.name),
      ),
        body: Center(
      child: Text(widget.form.name),
    ));
  }
}
