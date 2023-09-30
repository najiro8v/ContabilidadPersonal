import 'package:contabilidad/domain/entities/models/account.dart';
import 'package:flutter/foundation.dart';

class ValueEntry implements BaseAccount {
  String? desc;
  double? value;
  double? quantity;
  int? date;
  double? latitud;
  final double? length;
  int? type;
  int? entry;
  String? entryName;
  String? categoryName;

  ValueEntry(
      {required this.desc,
      required this.value,
      required this.date,
      required this.latitud,
      required this.length,
      required this.type,
      required this.quantity,
      required this.entry,
      this.entryName,
      this.categoryName,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      "entry_id": entry,
      "type_id": type,
      "desc": desc,
      "value": value,
      "date": date,
      "latitud": latitud,
      "length": length,
      "quantity": quantity
    };
  }

  static ValueEntry fromMap(Map<String, dynamic> json) {
    var value = ValueEntry(
        desc: "",
        value: 0,
        date: 0,
        latitud: 0,
        length: 0,
        type: 0,
        quantity: 0,
        entry: 0);
    try {
      int length = json["length"] ?? 0;
      int latitud = json["latitud"] ?? 0;
      value = ValueEntry(
          desc: json["desc"].toString(),
          value: json["value"] as double,
          date: json["date"],
          latitud: latitud.toDouble(),
          length: length.toDouble(),
          type: json["type_id"],
          quantity: json["quantity"] as double,
          entry: json["entry_id"],
          id: json["Id_Value_Entry"]);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {}
    return value;
  }

  ValueEntry copyWith({
    int? id,
    double? value,
    String? categoryName,
    String? desc,
    int? date,
    double? latitud,
    double? length,
    int? type,
    int? entry,
    String? entryName,
    double? quantity,
  }) {
    return ValueEntry(
        desc: desc ?? this.desc,
        value: value ?? this.value,
        date: date ?? this.date,
        latitud: latitud ?? this.latitud,
        length: length ?? this.length,
        type: type ?? this.type,
        entry: entry ?? this.entry,
        entryName: entryName ?? this.entryName,
        categoryName: categoryName ?? this.categoryName,
        id: id ?? this.id,
        quantity: quantity ?? this.quantity);
  }

  @override
  int? id;
}
