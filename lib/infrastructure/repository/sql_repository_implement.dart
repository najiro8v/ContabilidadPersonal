import 'package:contabilidad/domain/datasources/datasources.dart';
import 'package:contabilidad/domain/repository/repository.dart';

import '../../domain/entities/models/account.dart';
import '../../domain/entities/models/query_option.dart';

class SqlrepositoryImplements<T extends BaseAccount> implements Repository<T> {
  final Datasources<T> datasource;

  SqlrepositoryImplements(this.datasource);

  @override
  Future<T?> add(obj, {QueryOption? query}) async {
    return await datasource.add(obj);
  }

  @override
  Future<T?> find(obj, {QueryOption? query}) async {
    return await datasource.find(obj);
  }

  @override
  Future<List<T?>> getAll({QueryOption? query}) async {
    return datasource.getAll();
  }

  @override
  Future<bool> remove(String? id, {QueryOption? query}) async {
    return datasource.remove(int.parse(id!), "");
  }
}
