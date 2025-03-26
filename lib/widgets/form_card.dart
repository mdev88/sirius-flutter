import 'package:flutter/material.dart';
import 'package:sirius_flutter/models/sirius_form.dart';

class FormCard extends StatelessWidget {
  const FormCard({super.key, required this.form});

  final SiriusForm form;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(form.name),);
  }
}
