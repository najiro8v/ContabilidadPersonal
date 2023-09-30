import 'package:contabilidad/domain/entities/models/account.dart';

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
