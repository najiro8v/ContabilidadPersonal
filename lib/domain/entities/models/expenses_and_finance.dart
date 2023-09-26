import 'package:contabilidad/domain/entities/models/account.dart';

class Category implements BaseAccount {
  String? name;
  String? key;
  bool? enable;
  @override
  int? id;
  Category({required this.name, required this.key, this.enable, this.id});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "key": key,
      "Id_Category": id,
      "enable": enable == true || enable == null ? 1 : 0
    };
  }

  Map<String, dynamic> toMapAll() {
    return {
      "name": name,
      "key": key,
      "Id_Category": id,
      "enable": enable == true || enable == null ? 1 : 0
    };
  }

  static Category fromMap(Map<String, dynamic> json) {
    return Category(
      key: json["key"],
      name: json["name"],
      id: json["id"] ?? json["Id_Category"],
      enable: json["enable"] == 1 ? true : false,
    );
  }

  Category copyWith({String? name, String? key, bool? enable, int? id}) {
    return Category(
      key: key ?? this.key,
      name: name ?? this.name,
      id: id ?? this.id,
      enable: enable ?? this.enable,
    );
  }

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

  static Entry fromMap(Map<String, dynamic> json) => Entry(
      value: json['value'],
      category: json['category_id'],
      key: json['key'],
      name: json['name'],
      categoryKey: json['categoryKey'],
      id: json['Id_Entry']);

  Entry copyWith(
      {String? name,
      String? key,
      bool? enable,
      int? id,
      double? value,
      int? category,
      String? categoryKey,
      String? categoryName}) {
    return Entry(
        key: key ?? this.key,
        name: name ?? this.name,
        id: id ?? this.id,
        category: category ?? this.category,
        value: value ?? this.value,
        categoryKey: categoryKey ?? this.categoryKey,
        categoryName: categoryName ?? this.categoryName);
  }

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

  static ValueEntry fromMap(Map<String, dynamic> json) {
    return ValueEntry(
        entry: json["entry_id"],
        type: json["type_id"] ?? 0,
        desc: json["desc"],
        value: json["value"],
        date: json["date"],
        latitud: json["latitud"] ?? 1,
        length: json["length"] ?? 1);
  }

  @override
  int? id;
}
