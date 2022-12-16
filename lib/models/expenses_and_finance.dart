class Category {
  final String? name;
  final String? key;
  final int? id;
  Category({required this.name, required this.key, this.id});

  Map<String, dynamic> toMap() {
    return {"name": name, "key": key};
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
  final String? desc;
  final double? value;
  final int? date;
  final double? latitud;
  final double? length;
  final int? type;
  final int? entry;
  final String? entryName;
  final String? categoryName;

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
}
