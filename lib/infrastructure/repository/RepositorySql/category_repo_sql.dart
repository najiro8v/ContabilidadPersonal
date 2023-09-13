import 'package:contabilidad/domain/entities/models/models.dart'
    show Category, QueryOption;
import 'package:contabilidad/infrastructure/helppers/sql/helppers_category_sql.dart';
import '../../datasources/sql_lite_datasources.dart';

class CategorySQLImplement {
  static const String dbName = "Category";
  final sqlPool =
      SqlLiteDataSource<Category>(dbName: dbName, fromMap: Category.fromMap);

  Future<List<Category>> find({Category? entity}) async {
    final queryOption = HelppersCategorySQL.ObjectToQuery(entity, dbName);
    final list = await sqlPool.getAll(queryOption: queryOption);
    return list;
  }

  Future<Category> insert({required Category entity}) async {
    final list = await sqlPool.add(entity);
    return list;
  }
}
