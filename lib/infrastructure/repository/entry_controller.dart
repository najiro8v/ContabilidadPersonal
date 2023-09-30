import 'package:contabilidad/domain/entities/entities.dart' show Entry;
import 'RepositorySql/repository_sql.dart' show EntrySQLImplement;

class EntryController {
  final datasource = EntrySQLImplement();

  Future<List<Entry>> find({Entry? entity}) async {
    return await datasource.find(entity: entity);
  }

  Future<List<Entry>> find1({Entry? entity}) async {
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
