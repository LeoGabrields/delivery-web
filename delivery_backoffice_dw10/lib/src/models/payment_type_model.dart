import 'dart:convert';

class PaymentTypeModel {
  final int? id;
  final String name;
  final String acronym;
  final bool enabled;

  PaymentTypeModel({
    required this.id,
    required this.name,
    required this.acronym,
    required this.enabled,
  });

  factory PaymentTypeModel.fromMap(Map<String, dynamic> map) {
    return PaymentTypeModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: (map['name'] ?? '') as String,
      acronym: (map['acronym'] ?? '') as String,
      enabled: (map['enabled'] ?? false) as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'acronym': acronym,
      'enabled': enabled,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory PaymentTypeModel.fromJson(String source) {
    return PaymentTypeModel.fromMap(
      jsonDecode(source) as Map<String, dynamic>,
    );
  }
}
