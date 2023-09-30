import 'package:contabilidad/domain/entities/entities.dart' show Category;
import 'RepositorySql/repository_sql.dart' show CategorySQLImplement;

class CategoryController {
  final datasource = CategorySQLImplement();

  Future<List<Category>> find({Category? entity}) async {
    return await datasource.find(entity: entity);
  }

  Future<Category> insert({required Category entity}) async {
    return await datasource.insert(entity: entity);
  }

  Future<Category> findUpdate({required Category entity}) async {
    return await datasource.findUpdate(entity: entity);
  }
}
