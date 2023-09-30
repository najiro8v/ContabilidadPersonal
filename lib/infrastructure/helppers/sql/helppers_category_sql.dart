import 'package:contabilidad/domain/entities/models/models.dart';

class HelppersSQL {
  static QueryOption? objectToQuery(Map<String, dynamic>? model, String db) {
    if (model == null) return null;
    String whereString = "";
    final List<String> whereList = [];
    final List<Object> whereListArgs = [];
    model.keys.map((e) {
      whereList.add('$e = ?');
      final value = isDateFormat(e, model[e]);
      whereListArgs.add(value);
    });
    whereString = whereList.join(" AND ");

    return QueryOption(where: whereString, whereArgs: whereListArgs);
  }

  static dynamic isDateFormat(dynamic key, dynamic value) {
    if (key != "date") return value;
    return DateTime(value).millisecondsSinceEpoch;
  }
}
