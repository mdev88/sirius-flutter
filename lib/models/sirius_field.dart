class SiriusField {
  SiriusField({
    required this.label,
    required this.ttype,
    required this.type,
  });

  /*
  {
      "label": "text",
      "ttype": "block",
      "type": "text"
  }
   */

  String label;
  String ttype;
  String type;

  factory SiriusField.fromJson(Map<String, dynamic> json) {
    return SiriusField(
      label: json['label'],
      ttype: json['ttype'],
      type: json['type'],
    );
  }
}