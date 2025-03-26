import 'sirius_field.dart';
class SiriusForm {
  SiriusForm({
    required this.name,
    required this.type,
    required this.canCreate,
    required this.canRead,
    required this.canWrite,
    required this.canUnlink,
    required this.fields,
  });

  /*
    [
        {
            "name": "Contact",
            "type": "form",
            "can_create": true,
            "can_read": true,
            "can_write": true,
            "can_unlink": false,
            "fields": [
                {
                    "label": "text",
                    "ttype": "block",
                    "type": "text"
                }
            ]
        }
    ]
   */

  String name;
  String type;
  bool canCreate;
  bool canRead;
  bool canWrite;
  bool canUnlink;
  List<SiriusField> fields;

  factory SiriusForm.fromJson(Map<String, dynamic> json) {
    return SiriusForm(
      name: json['name'],
      type: json['type'],
      canCreate: json['can_create'],
      canRead: json['can_read'],
      canWrite: json['can_write'],
      canUnlink: json['can_unlink'],
      fields: List<SiriusField>.from(
          json['fields'].map((x) => SiriusField.fromJson(x))),
    );
  }
}
