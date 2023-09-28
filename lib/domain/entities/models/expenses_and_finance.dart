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
      print(e);
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
