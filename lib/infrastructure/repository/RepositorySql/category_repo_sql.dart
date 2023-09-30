import 'package:contabilidad/domain/entities/models/models.dart' show Category;
import 'package:contabilidad/infrastructure/helppers/sql/helppers_category_sql.dart';
import 'package:contabilidad/infrastructure/datasources/sql/sql_lite_datasources.dart';

class CategorySQLImplement {
  static const String dbName = "Category";
  static const String idName = "Id_Category";
  final sqlPool =
      SqlLiteDataSource<Category>(dbName: dbName, fromMap: Category.fromMap);

  Future<List<Category>> find({Category? entity}) async {
    final queryOption = HelppersSQL.objectToQuery(entity?.toMap(), dbName);
    final list = await sqlPool.getAll(queryOption: queryOption);
    return list;
  }

  Future<Category> insert({required Category entity}) async {
    final list = await sqlPool.add(entity);
    return list;
  }

  Future<Category> findUpdate({required Category entity}) async {
    final list = await sqlPool.findUpdate(entity, idName);
    return list;
  }
}
