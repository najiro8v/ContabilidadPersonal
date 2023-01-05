class Category {
  String? name;
  String? key;
  bool? enable;
  final int? id;
  Category({required this.name, required this.key, this.id, this.enable});

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
}

class Type {
  final String? name;
  Type({required this.name});

  Map<String, dynamic> toMap() {
    return {"name": name};
  }
}

class Entry {
  final int? id;
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
}

class ValueEntry {
  final int? id;
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
        type: json["type_id"],
        desc: json["desc"],
        value: json["value"],
        date: json["date"],
        latitud: json["latitud"],
        length: json["length"]);
  }
}
