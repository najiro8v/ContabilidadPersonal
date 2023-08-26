import 'package:contabilidad/domain/entities/models/models.dart';

abstract class Datasources<T> {
  Future<List<T?>> getAll({QueryOption? query});
  Future<T?> find(T obj, {QueryOption? query});
  Future<bool> remove(String? id, {QueryOption? query});
  Future<T?> add(T obj, {QueryOption? query});
}
