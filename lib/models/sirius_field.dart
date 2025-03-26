import 'package:sirius_flutter/models/sirius_base_field.dart';

class SiriusField extends SiriusBaseField {
  SiriusField({
    required this.label,
    required this.type,
    required super.ttype,
  });

  /*
  {
      "label": "text",
      "ttype": "block",
      "type": "text"
  }
   */

  String label;

  // String ttype;
  String type;

  factory SiriusField.fromJson(Map<String, dynamic> json) {
    return SiriusField(
      label: json['label'],
      ttype: json['ttype'],
      type: json['type'],
    );
  }
}
