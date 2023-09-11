import 'package:contabilidad/domain/entities/models/models.dart';

abstract class Datasources<T> {
  Future<List<T?>> getAll({QueryOption? queryOption, String? query});
  Future<T?> find(T obj, {QueryOption? queryOption, String? query});
  Future<bool> remove(String? id, {QueryOption? queryOption, String? query});
  Future<T?> add(T obj);
}
