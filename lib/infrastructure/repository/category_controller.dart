import 'package:contabilidad/domain/entities/models/expenses_and_finance.dart';
import 'RepositorySql/category_repo_sql.dart';

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

class ValueEntryController {
  final datasource = ValueEntrySQLImplement();

  Future<List<ValueEntry>> find({ValueEntry? entity}) async {
    return await datasource.find(entity: entity);
  }

  Future<ValueEntry> insert({required ValueEntry entity}) async {
    return await datasource.insert(entity: entity);
  }

  Future<List<ValueEntry>> findByEntry({required List<int> id}) async {
    return await datasource.getByEntry(id: id);
  }

  Future<ValueEntry> findUpdate({required ValueEntry entity}) async {
    return await datasource.findUpdate(entity: entity);
  }

  Future<bool> remove({required int id}) async {
    return await datasource.remove(id: id);
  }
}

class EntryController {
  final datasource = EntrySQLImplement();

  Future<List<Entry>> find({Entry? entity}) async {
    return await datasource.find(entity: entity);
  }

  Future<Entry> insert({required Entry entity}) async {
    return await datasource.insert(entity: entity);
  }

  Future<List<Entry>> findByCategory({required List<int> id}) async {
    return await datasource.getByCategory(id: id);
  }

  Future<Entry> findUpdate({required Entry entity}) async {
    return await datasource.findUpdate(entity: entity);
  }

  Future<bool> remove({required int id}) async {
    return await datasource.remove(id: id);
  }
}
