import 'package:contabilidad/domain/entities/entities.dart' show ValueEntry;
import 'RepositorySql/repository_sql.dart' show ValueEntrySQLImplement;

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
