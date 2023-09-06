import 'package:contabilidad/domain/entities/models/account.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Category implements BaseAccount {
  String? name;
  String? key;
  bool? enable;
  @override
  int? id;
  Category({required this.name, required this.key, this.enable, this.id});

  Map<String, dynamic> toMap() {
    return {"name": name, "key": key, "enable": enable == true ? 1 : 0};
  }

  Map<String, dynamic> toMapAll() {
    return {
      "name": name,
      "key": key,
      "id": id,
      "enable": enable == true ? 1 : 0
    };
  }

  static Category fromMap(Map<String, dynamic> json) => Category(
        key: json["key"],
        name: json["name"],
        id: json["id"],
        enable: json["enable"] == 1 ? true : false,
      );
  /*@override
  static Category fromMap(Map<String, dynamic> json) => Category(
        key: json["key"],
        name: json["name"],
        id: json["id"],
        enable: json["enable"] == 1 ? true : false,
      );*/
}

class Type {
  final String? name;
  Type({required this.name});

  Map<String, dynamic> toMap() {
    return {"name": name};
  }
}

class Entry implements BaseAccount {
  String key;
  String? name;
  double? value;
  final int? category;
  final String? categoryKey;
  final String? categoryName;

  Entry(
      {required this.key,
      required this.name,
      required this.value,
      required this.category,
      this.categoryKey,
      this.categoryName,
      this.id});
  Map<String, dynamic> toMap() {
    return {"name": name, "key": key, "category_id": category, "value": value};
  }

  Map<String, dynamic> toMapAll() {
    return {
      "name": name,
      "key": key,
      "category_id": category,
      "value": value,
      "id": id
    };
  }

  Entry fromMap(Map<String, dynamic> json) => Entry(
      value: json['value'],
      category: json['category_id'],
      key: json['key'],
      name: json['name'],
      categoryKey: json['categoryKey'],
      id: json['Id_Entry']);

  @override
  int? id;
}

class ValueEntry implements BaseAccount {
  String? desc;
  double? value;
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
    };
  }

  ValueEntry fromMap(Map<String, dynamic> json) {
    return ValueEntry(
        entry: json["entry_id"],
        type: json["type_id"],
        desc: json["desc"],
        value: json["value"],
        date: json["date"],
        latitud: json["latitud"],
        length: json["length"]);
  }

  @override
  int? id;
}
