abstract class Datasources<T> {
  Future<List<T?>> getAll();
  Future<T?> find(T obj);
  Future<bool> remove(String? id);
  Future<T?> add(T obj);
}
