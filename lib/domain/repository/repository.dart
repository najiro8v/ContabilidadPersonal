import '../entities/models/query_option.dart';

abstract class Repository<T> {
  Future<List<T?>> getAll({QueryOption? query});
  Future<T?> find(T obj, {QueryOption? query});
  Future<bool> remove(String? id, {QueryOption? query});
  Future<T?> add(T obj, {QueryOption? query});
}
