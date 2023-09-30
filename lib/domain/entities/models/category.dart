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
}
