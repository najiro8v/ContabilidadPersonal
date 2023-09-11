import 'package:contabilidad/domain/datasources/datasources.dart';
import 'package:contabilidad/domain/entities/models/models.dart';

import 'db/db.dart';

class SqlLiteDataSource<T extends BaseAccount> implements Datasources<T> {
  List<T> list = [];
  final String dbName;
  final T Function(Map<String, Object?> json) fromMap;

  SqlLiteDataSource({required this.dbName, required this.fromMap});

  @override
  Future<T> add(T obj) async {
    dynamic element = await DatabaseSQL.insert(dbName, obj);
    return element as T;
  }

  @override
  Future<T> find(T obj, {QueryOption? queryOption, String? query}) async {
    List<dynamic> list = await DatabaseSQL.get(dbName,
        queryOption: queryOption, query: query ?? "");
    return fromMap(list.first);
  }

  @override
  Future<List<T>> getAll({QueryOption? queryOption, String? query}) async {
    List<dynamic> list = await DatabaseSQL.get(dbName,
        queryOption: queryOption, query: query ?? "");
    return list.map(
      (e) {
        return fromMap(e);
      },
    ).toList();
  }

  @override
  Future<bool> remove(String? id, {QueryOption? queryOption, String? query}) {
    // TODO: implement remove
    throw UnimplementedError();
  }
}

/*
 static Future<List<dynamic>> get(String dbName,
      {String queryOption = "", QueryOption? queryOption}) async {
    Database database = await instance.database;

    final List<Map<String, dynamic>> result =
        queryOption.isEmpty && queryOption == null
            ? await database.queryOption(dbName)
            : queryOption != null
                ? await database.queryOption(dbName,
                    columns: queryOption.columns,
                    distinct: queryOption.distinct,
                    groupBy: queryOption.groupBy,
                    having: queryOption.having,
                    limit: queryOption.limit,
                    offset: queryOption.offset,
                    orderBy: queryOption.orderBy,
                    where: queryOption.where,
                    whereArgs: queryOption.whereArgs)
                : await database.rawQuery(queryOption);

    return result.toList();
  } */


/*
  static const String dbName = "Category";
  static Future<List<Category>> get() async {
    List<dynamic> listado = await DatabaseSQL.get(dbName);
    return List.generate(
        listado.length,
        (i) => Category(
            key: listado[i]['key'],
            name: listado[i]['name'],
            id: listado[i]['Id_Category'],
            enable: listado[i]['enable'] == 1 ? true : false)); */