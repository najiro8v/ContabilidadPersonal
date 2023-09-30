import 'package:contabilidad/domain/entities/models/models.dart';

abstract class Datasources<T> {
  Future<List<T?>> getAll(
      {QueryOption? queryOption, String? query, List<dynamic>? args});
  Future<T?> find(T obj, {QueryOption? queryOption, String? query});
  Future<bool> remove(int? id, String idName,
      {QueryOption? queryOption, String? query});
  Future<T?> add(T obj);
  Future<T?> findUpdate(T obj, String idName);
}
